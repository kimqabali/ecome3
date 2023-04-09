<?php

namespace App\Http\Controllers\Web;

use App\User;
use Carbon\Carbon;
use App\CPU\Convert;
use App\CPU\Helpers;
use App\Model\Order;
use App\Model\Skill;
use App\Model\Salary;
use App\Model\License;
use App\Model\Advertis;
use App\Model\JobTitle;
use App\Model\Language;
use App\Model\Wishlist;
use App\Model\WorkDays;
use App\CPU\ImageManager;
use App\CPU\OrderManager;
use App\Model\Experience;
use App\Model\Governorate;
use App\Model\Nationality;
use App\Model\OrderDetail;
use App\Model\Translation;
use App\Model\CareerSector;
use App\Model\CityAdvertis;
use App\Model\ExtraBenefit;
use App\Model\TypeContract;
use App\Model\TypeWorkHour;
use App\Traits\CommonTrait;
use App\CPU\CustomerManager;
use App\Model\AdvertiseType;
use App\Model\RefundRequest;
use App\Model\StateAdvertis;
use App\Model\SupportTicket;
use Illuminate\Http\Request;
use App\Model\DeliveryZipCode;
use App\Model\EducationDegree;
use App\Model\ShippingAddress;
use function App\CPU\translate;
use function React\Promise\all;
use App\Model\DeliveryCountryCode;
use Barryvdh\DomPDF\Facade as PDF;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use App\Model\Admin;
use App\Model\SaveAdvertis as ModelSaveAdvertis;
use App\SaveAdvertis;
use Brian2694\Toastr\Facades\Toastr;
use Illuminate\Support\Facades\Auth;
use Intervention\Image\Facades\Image;
use Illuminate\Support\Facades\Storage;
use PhpParser\Node\Expr\AssignOp\Concat;

class UserProfileController extends Controller
{
        use CommonTrait;
        public function user_account(Request $request)
        {
            if (auth('customer')->check()) {
                $customerDetail = User::where('id', auth('customer')->id())->first();
                return view('web-views.users-profile.account-profile', compact('customerDetail'));
            } else {
                return redirect()->route('home');
            }
        }

        public function user_update(Request $request)
        {
            $request->validate([
                'f_name' => 'required',
                'l_name' => 'required',
            ], [
                'f_name.required' => 'First name is required',
                'l_name.required' => 'Last name is required',
            ]);
            if ($request->password) {
                $request->validate([
                    'password' => 'required|min:6|same:confirm_password'
                ]);
            }

            $image = $request->file('image');

            if ($image != null) {
                $imageName = ImageManager::update('profile/', auth('customer')->user()->image, 'png', $request->file('image'));
            } else {
                $imageName = auth('customer')->user()->image;
            }

            User::where('id', auth('customer')->id())->update([
                'image' => $imageName,
            ]);

            $userDetails = [
                'f_name' => $request->f_name,
                'l_name' => $request->l_name,
                'phone' => $request->phone,
                'password' => strlen($request->password) > 5 ? bcrypt($request->password) : auth('customer')->user()->password,
            ];
            if (auth('customer')->check()) {
                User::where(['id' => auth('customer')->id()])->update($userDetails);
                Toastr::info(translate('updated_successfully'));
                return redirect()->back();
            } else {
                return redirect()->back();
            }
        }

        public function account_delete($id)
        {
            if(auth('customer')->id() == $id)
            {
                $user = User::find($id);
                auth()->guard('customer')->logout();

                ImageManager::delete('/profile/' . $user['image']);
                session()->forget('wish_list');

                $user->delete();
                Toastr::info(translate('Your_account_deleted_successfully!!'));
                return redirect()->route('home');
            }else{
                Toastr::warning('access_denied!!');
            }

        }

        public function account_address()
        {
            $country_restrict_status = Helpers::get_business_settings('delivery_country_restriction');
            $zip_restrict_status = Helpers::get_business_settings('delivery_zip_code_area_restriction');

            if ($country_restrict_status) {
                $data = $this->get_delivery_country_array();
            } else {
                $data = COUNTRIES;
            }

            if ($zip_restrict_status) {
                $zip_codes = DeliveryZipCode::all();
            } else {
                $zip_codes = 0;
            }
            if (auth('customer')->check()) {
                $shippingAddresses = \App\Model\ShippingAddress::where('customer_id', auth('customer')->id())->get();
                return view('web-views.users-profile.account-address', compact('shippingAddresses', 'country_restrict_status', 'zip_restrict_status', 'data', 'zip_codes'));
            } else {
                return redirect()->route('home');
            }
        }

        public function address_store(Request $request)
        {
            $request->validate([
                'name' => 'required',
                'phone' => 'required',
                'city' => 'required',
                'zip' => 'required',
                'country' => 'required',
                'address' => 'required',
            ]);

            $country_restrict_status = Helpers::get_business_settings('delivery_country_restriction');
            $zip_restrict_status = Helpers::get_business_settings('delivery_zip_code_area_restriction');

            $country_exist = self::delivery_country_exist_check($request->country);
            $zipcode_exist = self::delivery_zipcode_exist_check($request->zip);

            if ($country_restrict_status && !$country_exist) {
                Toastr::error(translate('Delivery_unavailable_in_this_country!'));
                return back();
            }

            if ($zip_restrict_status && !$zipcode_exist) {
                Toastr::error(translate('Delivery_unavailable_in_this_zip_code_area!'));
                return back();
            }

            $address = [
                'customer_id' => auth('customer')->check() ? auth('customer')->id() : null,
                'contact_person_name' => $request->name,
                'address_type' => $request->addressAs,
                'address' => $request->address,
                'city' => $request->city,
                'zip' => $request->zip,
                'country' => $request->country,
                'phone' => $request->phone,
                'is_billing' =>$request->is_billing,
                'latitude' =>$request->latitude,
                'longitude' =>$request->longitude,
                'created_at' => now(),
                'updated_at' => now(),
            ];
            DB::table('shipping_addresses')->insert($address);
            return back();
        }

        public function address_edit(Request $request,$id)
        {
            $shippingAddress = ShippingAddress::where('customer_id',auth('customer')->id())->find($id);
            $country_restrict_status = Helpers::get_business_settings('delivery_country_restriction');
            $zip_restrict_status = Helpers::get_business_settings('delivery_zip_code_area_restriction');

            if ($country_restrict_status) {
                $delivery_countries = self::get_delivery_country_array();
            } else {
                $delivery_countries = 0;
            }
            if ($zip_restrict_status) {
                $delivery_zipcodes = DeliveryZipCode::all();
            } else {
                $delivery_zipcodes = 0;
            }
            if(isset($shippingAddress))
            {
                return view('web-views.users-profile.account-address-edit',compact('shippingAddress', 'country_restrict_status', 'zip_restrict_status', 'delivery_countries', 'delivery_zipcodes'));
            }else{
                Toastr::warning(translate('access_denied'));
                return back();
            }
        }

        public function address_update(Request $request)
        {
            $request->validate([
                'name' => 'required',
                'phone' => 'required',
                'city' => 'required',
                'zip' => 'required',
                'country' => 'required',
                'address' => 'required',
            ]);

            $country_restrict_status = Helpers::get_business_settings('delivery_country_restriction');
            $zip_restrict_status = Helpers::get_business_settings('delivery_zip_code_area_restriction');

            $country_exist = self::delivery_country_exist_check($request->country);
            $zipcode_exist = self::delivery_zipcode_exist_check($request->zip);

            if ($country_restrict_status && !$country_exist) {
                Toastr::error(translate('Delivery_unavailable_in_this_country!'));
                return back();
            }

            if ($zip_restrict_status && !$zipcode_exist) {
                Toastr::error(translate('Delivery_unavailable_in_this_zip_code_area!'));
                return back();
            }

            $updateAddress = [
                'contact_person_name' => $request->name,
                'address_type' => $request->addressAs,
                'address' => $request->address,
                'city' => $request->city,
                'zip' => $request->zip,
                'country' => $request->country,
                'phone' => $request->phone,
                'is_billing' =>$request->is_billing,
                'latitude' =>$request->latitude,
                'longitude' =>$request->longitude,
                'created_at' => now(),
                'updated_at' => now(),
            ];
            if (auth('customer')->check()) {
                ShippingAddress::where('id', $request->id)->update($updateAddress);
                Toastr::success(translate('Data_updated_successfully!'));
                return redirect()->back();
            } else {
                Toastr::error(translate('Insufficient_permission!'));
                return redirect()->back();
            }
        }

        public function address_delete(Request $request)
        {
            if (auth('customer')->check()) {
                ShippingAddress::destroy($request->id);
                return redirect()->back();
            } else {
                return redirect()->back();
            }
        }

        public function account_payment()
        {
            if (auth('customer')->check()) {
                return view('web-views.users-profile.account-payment');

            } else {
                return redirect()->route('home');
            }

        }

        public function account_oder()
        {
            $orders = Order::where('customer_id', auth('customer')->id())->orderBy('id','DESC')->paginate(15);
            return view('web-views.users-profile.account-orders', compact('orders'));
        }

        public function account_order_details(Request $request)
        {
            $order = Order::with(['details.product', 'delivery_man_review'])->find($request->id);
            return view('web-views.users-profile.account-order-details', compact('order'));
        }

        public function account_wishlist()
        {
            if (auth('customer')->check()) {
                $wishlists = Wishlist::where('customer_id', auth('customer')->id())->get();
                return view('web-views.products.wishlist', compact('wishlists'));
            } else {
                return redirect()->route('home');
            }
        }

        public function account_tickets()
        {
            if (auth('customer')->check()) {
                $supportTickets = SupportTicket::where('customer_id', auth('customer')->id())->get();
                return view('web-views.users-profile.account-tickets', compact('supportTickets'));
            } else {
                return redirect()->route('home');
            }
        }

        public function ticket_submit(Request $request)
        {
            $ticket = [
                'subject' => $request['ticket_subject'],
                'type' => $request['ticket_type'],
                'customer_id' => auth('customer')->check() ? auth('customer')->id() : null,
                'priority' => $request['ticket_priority'],
                'description' => $request['ticket_description'],
                'created_at' => now(),
                'updated_at' => now(),
            ];
            DB::table('support_tickets')->insert($ticket);
            return back();
        }

        public function single_ticket(Request $request)
        {
            $ticket = SupportTicket::where('id', $request->id)->first();
            return view('web-views.users-profile.ticket-view', compact('ticket'));
        }

        public function comment_submit(Request $request, $id)
        {
            DB::table('support_tickets')->where(['id' => $id])->update([
                'status' => 'open',
                'updated_at' => now(),
            ]);

            DB::table('support_ticket_convs')->insert([
                'customer_message' => $request->comment,
                'support_ticket_id' => $id,
                'position' => 0,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
            return back();
        }

        public function support_ticket_close($id)
        {
            DB::table('support_tickets')->where(['id' => $id])->update([
                'status' => 'close',
                'updated_at' => now(),
            ]);
            Toastr::success('Ticket closed!');
            return redirect('/account-tickets');
        }

        public function account_transaction()
        {
            $customer_id = auth('customer')->id();
            $customer_type = 'customer';
            if (auth('customer')->check()) {
                $transactionHistory = CustomerManager::user_transactions($customer_id, $customer_type);
                return view('web-views.users-profile.account-transaction', compact('transactionHistory'));
            } else {
                return redirect()->route('home');
            }
        }

        public function support_ticket_delete(Request $request)
        {

            if (auth('customer')->check()) {
                $support = SupportTicket::find($request->id);
                $support->delete();
                return redirect()->back();
            } else {
                return redirect()->back();
            }

        }

        public function account_wallet_history($user_id, $user_type = 'customer')
        {
            $customer_id = auth('customer')->id();
            if (auth('customer')->check()) {
                $wallerHistory = CustomerManager::user_wallet_histories($customer_id);
                return view('web-views.users-profile.account-wallet', compact('wallerHistory'));
            } else {
                return redirect()->route('home');
            }

        }

        public function track_order()
        {
            return view('web-views.order-tracking-page');
        }

        public function track_order_result(Request $request)
        {
            $user =  auth('customer')->user();
            if(!isset($user)){
                $user_id = User::where('phone',$request->phone_number)->first()->id;
                $orderDetails = Order::where('id',$request['order_id'])->whereHas('details',function ($query) use($user_id){
                    $query->where('customer_id',$user_id);
                })->first();

            }else{
                if($user->phone == $request->phone_number){
                    $orderDetails = Order::where('id',$request['order_id'])->whereHas('details',function ($query){
                        $query->where('customer_id',auth('customer')->id());
                    })->first();
                }
                if($request->from_order_details==1)
                {
                    $orderDetails = Order::where('id',$request['order_id'])->whereHas('details',function ($query){
                        $query->where('customer_id',auth('customer')->id());
                    })->first();
                }

            }


            if (isset($orderDetails)){
                return view('web-views.order-tracking', compact('orderDetails'));
            }

            return redirect()->route('track-order.index')->with('Error', \App\CPU\translate('Invalid Order Id or Phone Number'));
        }

        public function track_last_order()
        {
            $orderDetails = OrderManager::track_order(Order::where('customer_id', auth('customer')->id())->latest()->first()->id);

            if ($orderDetails != null) {
                return view('web-views.order-tracking', compact('orderDetails'));
            } else {
                return redirect()->route('track-order.index')->with('Error', \App\CPU\translate('Invalid Order Id or Phone Number'));
            }

        }

        public function order_cancel($id)
        {
            $order = Order::where(['id' => $id])->first();
            if ($order['payment_method'] == 'cash_on_delivery' && $order['order_status'] == 'pending') {
                OrderManager::stock_update_on_order_status_change($order, 'canceled');
                Order::where(['id' => $id])->update([
                    'order_status' => 'canceled'
                ]);
                Toastr::success(translate('successfully_canceled'));
                return back();
            }
            Toastr::error(translate('status_not_changable_now'));
            return back();
        }
        public function refund_request(Request $request,$id)
        {
            $order_details = OrderDetail::find($id);
            $user = auth('customer')->user();

            $wallet_status = Helpers::get_business_settings('wallet_status');
            $loyalty_point_status = Helpers::get_business_settings('loyalty_point_status');
            if($loyalty_point_status == 1)
            {
                $loyalty_point = CustomerManager::count_loyalty_point_for_amount($id);

                if($user->loyalty_point < $loyalty_point)
                {
                    Toastr::warning(translate('you have not sufficient loyalty point to refund this order!!'));
                    return back();
                }
            }

            return view('web-views.users-profile.refund-request',compact('order_details'));
        }
        public function store_refund(Request $request)
        {
            $request->validate([
                'order_details_id' => 'required',
                'amount' => 'required',
                'refund_reason' => 'required'

            ]);
            $order_details = OrderDetail::find($request->order_details_id);
            $user = auth('customer')->user();


            $loyalty_point_status = Helpers::get_business_settings('loyalty_point_status');
            if($loyalty_point_status == 1)
            {
                $loyalty_point = CustomerManager::count_loyalty_point_for_amount($request->order_details_id);

                if($user->loyalty_point < $loyalty_point)
                {
                    Toastr::warning(translate('you have not sufficient loyalty point to refund this order!!'));
                    return back();
                }
            }
            $refund_request = new RefundRequest;
            $refund_request->order_details_id = $request->order_details_id;
            $refund_request->customer_id = auth('customer')->id();
            $refund_request->status = 'pending';
            $refund_request->amount = $request->amount;
            $refund_request->product_id = $order_details->product_id;
            $refund_request->order_id = $order_details->order_id;
            $refund_request->refund_reason = $request->refund_reason;

            if ($request->file('images')) {
                foreach ($request->file('images') as $img) {
                    $product_images[] = ImageManager::upload('refund/', 'png', $img);
                }
                $refund_request->images = json_encode($product_images);
            }
            $refund_request->save();

            $order_details->refund_request = 1;
            $order_details->save();

            Toastr::success(translate('refund_requested_successful!!'));
            return redirect()->route('account-order-details',['id'=>$order_details->order_id]);
        }

        public function generate_invoice($id)
        {
            $order = Order::with('seller')->with('shipping')->where('id', $id)->first();
            $data["email"] = $order->customer["email"];
            $data["order"] = $order;

            $mpdf_view = \View::make('web-views.invoice', compact('order'));
            Helpers::gen_mpdf($mpdf_view, 'order_invoice_', $order->id);
        }
        public function refund_details($id)
        {
            $order_details = OrderDetail::find($id);

            $refund = RefundRequest::where('customer_id',auth('customer')->id())
                                    ->where('order_details_id',$order_details->id )->first();

            return view('web-views.users-profile.refund-details',compact('order_details','refund'));
        }

        public function submit_review(Request $request,$id)
        {
            $order_details = OrderDetail::where(['id'=>$id])->whereHas('order', function($q){
                $q->where(['customer_id'=>auth('customer')->id(),'payment_status'=>'paid']);
            })->first();

            if(!$order_details){
                Toastr::error(translate('Invalid order!'));
                return redirect('/');
            }

            return view('web-views.users-profile.submit-review',compact('order_details'));

        }

    public function AddAdvertisement()
    {

        

        return view('web-views.users-profile.Advertisment', [
            'CareerSector' => CareerSector::all(),
            'jobTitle' => JobTitle::all(),
            'AdvertiserType' => AdvertiseType::all(),
            'TypeOfContract' => TypeContract::all(),
            'numberWorkingDay' => WorkDays::all(),
            'workHour' => TypeWorkHour::all(),
            'expectedSalary' => Salary::all(),
            'ExtraBenefit' => ExtraBenefit::all(),
            'educationDegree' => EducationDegree::all(),
            'ExperienceLevel' => Experience::all(),
            'Nationality' => Nationality::all(),
            'license' => License::all(),
            'langg' => Language::all(),
            'skill' => Skill::all(),
            'city_advertis' => CityAdvertis::all(),
            'state_advertis' => StateAdvertis::all(),
            'governorate' => Governorate::all(),
        ]);
    }

    public function AddAdvertisementApi()
    {

    return response()->json([
        'CareerSector' => CareerSector::all(),
        'jobTitle' => JobTitle::all(),
        'advertiserType' => AdvertiseType::all(),
        'contractType' => TypeContract::all(),
        'workDays' => WorkDays::all(),
        'workHours' => TypeWorkHour::all(),
        'salaryCurrency' => Salary::all(),
        'extraBenefit' => ExtraBenefit::all(),
        'educationDegree' => EducationDegree::all(),
        'experienceLevel' => Experience::all(),
        'nationality' => Nationality::all(),
        'licenses' => License::all(),
        'languages' => Language::all(),
        'skills' => Skill::all(),
        'stateAdvertis' => StateAdvertis::all(),
        'cityAdvertis' => CityAdvertis::all(),
        'governorate' => Governorate::all(),
        ]);
    }

        public function storeAdvertisement(Request $request)
        {


            $img = $this->uploadAttachments($request);
            $user = auth('customer')->user()->id;
            // dd($user);
            $actorType = 'App\Model\User';
            $Advertis = Advertis::create([
                'name' => $request->name,
                'description' => $request->description,
                'expected_salary' => $request->expected_salary,
                'work_from_home' => $request->work_from_home,
                'job_requires_vehicle' => $request->job_requires_vehicle,
                'Require_driver_license' => $request->Require_driver_license,
                'gender' => $request->gender,
                'career_sector_id' => $request->career_sector_id,
                'job_title_id' => $request->job_title_id,
                'advertise_type_id' => $request->advertise_type_id,
                'education_degree_id' => $request->education_degree_id,
                'type_contract_id' => $request->type_contract_id,
                'work_day_id' => $request->work_day_id,
                'type_work_hour_id' => $request->type_work_hour_id,
                'salary_id' => $request->salary_id,
                'experience_id' => $request->experience_id,
                'nationality_id' => $request->nationality_id,
                'city_advertis_id' => $request->city_advertis_id,
                'state_advertis_id' => $request->state_advertis_id,
                'governorates_id' => $request->governorates_id,
              
                'image' => $img,
                'actor_type' => $actorType,
                'actor_id' => $user,
            ]);



            $benefits = $request->ExtraBenefit;
            $Advertis->Benefits()->sync($benefits);

            $licenses = $request->license;
            $Advertis->licenses()->sync($licenses);

            $languagesSelect = $request->langg;
            $Advertis->Languages()->sync($languagesSelect);

            $skillSelect = $request->skill;
            $Advertis->Skills()->sync($skillSelect);


            $issaved = $Advertis->save();







        Toastr::success(\App\CPU\translate('Advertis_added_successfully!'));

        return redirect('AddAdvertisement')->with('message', 'Advertis_added_successfully!');




            // Toastr::success(\App\CPU\translate('Advertis_added_successfully!'));

            // return redirect('AddAdvertisement')->with('message', 'Advertis_added_successfully!');

    }

    public function storeAdvertisementApi(Request $request)
    {

        // dd($request);
        $request->validate([
            'name' => 'required',
            'description' => 'required',
            'work_from_home' => 'required',
            'job_requires_vehicle' => 'required',
            'Require_driver_license' => 'required',
            'gender' => 'required',
            'career_sector_id' => 'required',
            'job_title_id' => 'required',
            'advertise_type_id' => 'required',
            'education_degree_id' => 'required',
            'type_contract_id' => 'required',
            'work_day_id' => 'required',
            'type_work_hour_id' => 'required',
            'experience_id' => 'required',
            'nationality_id' => 'required',
            'city_advertis_id' => 'required',
            'state_advertis_id' => 'required',
            'ExtraBenefit' => 'required',
            'image' => 'required',
            
        ], [
            'name.required' => 'Job name is required',
            'description.required' => 'Job description is required',
            'work_from_home.required' => 'Work from home is required',
            'job_requires_vehicle.required' => 'Job requires vehicle is required',
            'Require_driver_license.required' => 'Require driver license is required',
            'gender.required' => 'Gender is required',
            'career_sector_id.required' => 'Career sector is required',
            'job_title_id.required' => 'Job title is required',
            'advertise_type_id.required' => 'Advertise type is required',
            'education_degree_id.required' => 'Education degree is required',
            'type_contract_id.required' => 'Type contract is required',
            'work_day_id.required' => 'Work day is required',
            'type_work_hour_id.required' => 'Work hour is required',
            'experience_id.required' => 'Experience is required',
            'nationality_id.required' => 'Nationality is required',
            'city_advertis_id.required' => 'City advertis is required',
            'state_advertis_id.required' => 'State advertis is required',
            'ExtraBenefit.required' => 'ExtraBenefit is required',
            'image.required' => 'Image is required',
        ]);
        if (!$request->salary_id==null && $request->expected_salary==null) {
            $request->validate([
                'expected_salary' => 'required'
            ],
            [
                'expected_salary.required' => 'You have selected the currency You must enter the expected salary' 
            ]
        );
        }elseif($request->salary_id==null && !$request->expected_salary==null) {
            $request->validate([
                'salary_id' => 'required'
            ],
            [
                'salary_id.required' => 'Select the currency for the expected salary' 
            ]
        );
        }
        if ($request->Require_driver_license=="Yes") {
            $request->validate([
                'license' => 'required'
            ],
            [
                'license.required' => 'Select the type of license' 
            ]
        );
        }
        $img = $this->uploadAttachments($request);
    
        $user = $request->user()->id;
        // dd($user);
        $actorType = 'App\Model\User';
        $Advertis = Advertis::create([
            'name' => $request->name,
            'description' => $request->description,
            'expected_salary' => $request->expected_salary,
            'work_from_home' => $request->work_from_home,
            'job_requires_vehicle' => $request->job_requires_vehicle,
            'Require_driver_license' => $request->Require_driver_license,
            'gender' => $request->gender,
            'career_sector_id' => $request->career_sector_id,
            'job_title_id' => $request->job_title_id,
            'advertise_type_id' => $request->advertise_type_id,
            'education_degree_id' => $request->education_degree_id,
            'type_contract_id' => $request->type_contract_id,
            'work_day_id' => $request->work_day_id,
            'type_work_hour_id' => $request->type_work_hour_id,
            'salary_id' => $request->salary_id,
            'experience_id' => $request->experience_id,
            'nationality_id' => $request->nationality_id,
            'city_advertis_id' => $request->city_advertis_id,
            'state_advertis_id' => $request->state_advertis_id,
            'governorates_id' => $request->governorates_id,  
        

        

        
            'image' =>$img,
            'actor_type' => $actorType,
            'actor_id' => $user,
        ]);
    


       // $benefits = $request->ExtraBenefit;
        $Advertis->Benefits()->sync($request->ExtraBenefit);

       // $licenses = $request->license;
        $Advertis->licenses()->sync($request->license);

       // $languagesSelect = $request->langg;
        $Advertis->Languages()->sync($request->langg);

      //  $skillSelect = $request->skill;
        $Advertis->Skills()->sync($request->skill);

        
        $issaved = $Advertis->save();

            Toastr::success(\App\CPU\translate('Advertis_added_successfully!'));
            return response()->json(['msg' => 'Advertis_added_successfully!']);
       




    }


        protected function uploadAttachments(Request $request)
        {


            if(!$request->hasFile('image')){

                return;
            }
            $files = $request->file('image');
            $image = [];
            foreach($files as $file){

                if($file->isValid()){

                    $path = $file->store('/', [
                        'disk' => 'uploads',
                    ]);

                    $image[] = $path;

                }
            }

            return $image;

        }

        public function disblayAdvertisement(Request $request)
        {
    
    
        // $actorDetail = User::user()->id->first();
            $Advertis = Advertis::with('Benefits', 'Skills', 'licenses', 'Languages', 'CareerSector', 'JobTitle', 'advertiseType',
            'educationDegree', 'typeContract', 'workDays', 'typeWorkHours', 'salary',  'experience', 'nationality', 'CityAdvertis',
            'StateAdvertis')->where('status', 'Active')->paginate(15);
            foreach($Advertis as $Advertisement ){
                
                if( $Advertisement->actor_type == 'App\Model\User'){
                    $Advertisement->actorDetail = User::select('id','f_name','l_name','phone','image','temporary_token')->where('id',  $Advertisement->actor_id)->first();
                    // $newArray['actorDetail']->name = $newArray['actorDetail']->f_name .$newArray['actorDetail']->l_name; 
                }else{
                    $Advertisement->actorDetail = Admin::select('id','name','phone','image')->where('id',  $Advertisement->actor_id)->first(); 
                }
            }
           
            $serch_value = '';
            return view('web-views.users-profile.display', compact('Advertis', 'serch_value'), [
                'CareerSector' => CareerSector::select('id', 'name')->get(),
                'JobTitle' => JobTitle::select('id', 'name')->get(),
                'stateAdvertis' => StateAdvertis::select('id', 'name')->get(),
                'CityAdvertis' => CityAdvertis::select('id', 'name')->get(),
            ]);
        }

    public function disblayAdvertisementApi(Request $request)
    {     
        $Advertis = Advertis::where('status', 'Active')->get();
        $data = [];
            foreach($Advertis as $Advertisement ){
                    $newArray=[];
                    $newArray['id'] = $Advertisement->id;
                    $newArray['name'] = $Advertisement->name;
                    $newArray['description'] = $Advertisement->description;
                    $newArray['image'] = $Advertisement->image;    
                        
                    $newArray['careerSector'] = $Advertisement->CareerSector->name;
                    $newArray['jobTitle'] = $Advertisement->JobTitle->name;
                    $newArray['advertiserType'] = $Advertisement->advertiseType->name;
                    $newArray['educationDegree'] = $Advertisement->educationDegree->name;
                    $newArray['experienceLevel'] = $Advertisement->experience->experiences_level;
                    $newArray['extraBenefit'] = $Advertisement->benefits;
                    $newArray['skills'] = $Advertisement->Skills;
                    $newArray['languages'] = $Advertisement->Languages;
                    $newArray['contractType'] = $Advertisement->typeContract->name;

                    $newArray['workFromHome'] = $Advertisement->work_from_home;
                    $newArray['workDays'] = $Advertisement->workDays->workDays;
                    $newArray['workHours'] = $Advertisement->typeWorkHours->name;
                    $newArray['jobRequiresVehicle'] = $Advertisement->job_requires_vehicle;
                    $newArray['requireDriverLicense'] = $Advertisement->Require_driver_license;
                    $newArray['licenses'] = $Advertisement->licenses;

                    $newArray['nationality'] = $Advertisement->nationality->name;
                    $newArray['gender'] = $Advertisement->gender;
                    $newArray['expectedSalary'] = $Advertisement->expected_salary;
                    $newArray['salaryCurrency'] = $Advertisement->salary->type;

                    $newArray['stateAdvertis'] = $Advertisement->StateAdvertis->name;
                    $newArray['cityAdvertis'] = $Advertisement->CityAdvertis->name;
                    $newArray['governorate'] = $Advertisement->governorate->name;
                                

                    $newArray['status'] = $Advertisement->status;
                    $newArray['created_at'] = $Advertisement->created_at;
                    $newArray['updated_at'] = $Advertisement->updated_at;
                
                    if( $Advertisement->actor_type == 'App\Model\User'){
                        $newArray['actorDetail'] = User::select('id',DB::raw(' CONCAT(f_name," ",l_name) AS name'),'phone','image')->where('id',  $Advertisement->actor_id)->first(); 
                    }else{
                        $newArray['actorDetail'] = Admin::select('id','name','phone','image')->where('id',  $Advertisement->actor_id)->first(); 
                    }
                    array_push($data , $newArray);
                    }
                
            return response()->json([
                'Advertis' => $data, 
                
                // 'CareerSector' => CareerSector->name,
                // 'CareerSector' => CareerSector::all(),
            
            ]);
    }

        public function disblay_AdvertisementApi(Request $request, $id)
        {

            $business_mode=Helpers::get_business_settings('business_mode');
        
            $skillSelect = $request->skill;
            $user = auth('customer')->user()->id;
            // $shop = Advertis::findOrFail($id);
            $Advertis = Advertis::with('Benefits', 'Skills', 'licenses', 'Languages', 'CareerSector', 'JobTitle', 'advertiseType',
            'educationDegree', 'typeContract', 'workDays', 'typeWorkHours', 'salary',  'experience', 'nationality', 'CityAdvertis',
            'StateAdvertis','governorate')->where('status', 'Active')->where('actor_id', $user)->first();
        
            //    $shop['actor'] = User::where('id',  $shop->actor_id)->first();
        
            

            //$skillSelect = $request->skill;
            //$Advertis->Skills()->sync($skillSelect);
            
                $actorDetail = User::where('id',  $Advertis->actor_id)->first();
            

            return response()->json(['Advertis' => $Advertis , 'actorDetail' => $actorDetail]);
        }

        public function saveAdvertisment(Request $request){

            if ($request->ajax()) {
                if (auth('customer')->check()) {
                    $wishlist = ModelSaveAdvertis::where('users_id', auth('customer')->id())->where('advertis_id', $request->advertis_id)->first();
                    if (empty($wishlist)) {

                        $wishlist = new ModelSaveAdvertis;
                        $wishlist->users_id = auth('customer')->id();
                        $wishlist->advertis_id = $request->advertis_id;
                        $wishlist->save();

                        $countWishlist = ModelSaveAdvertis::whereHas('wishlistAdvertis',function($q){
                            return $q;
                        })->where('users_id', auth('customer')->id())->get();

                        $data = \App\CPU\translate("Ad added to favourites");

                        $Advertis_count = ModelSaveAdvertis::where(['advertis_id' => $request->advertis_id])->count();
                        session()->put('wish_list_advertis', ModelSaveAdvertis::where('users_id', auth('customer')->user()->id)->pluck('advertis_id')->toArray());
                        return response()->json(['success' => $data, 'value' => 1, 'count' => count($countWishlist), 'id' => $request->advertis_id, 'Advertis_count' => $Advertis_count]);
                    } else {
                        $wishlist->delete();
                        return response()->json(['error' => 'deleted done', 'value' => 2]);
                    }

                } else {
                    $data = translate('login_first');
                    return response()->json(['error' => $data, 'value' => 0]);
                }

            }

        }
    



        public function wishlistsAdvertisment(){
            $wishlists = ModelSaveAdvertis::whereHas('wishlistAdvertis',function($q){
                return $q;
            })->where('users_id', auth('customer')->id())->get();
            return view('web-views.users-profile.wishlistAdvertis', compact('wishlists'));
        }


        public function deleteWishlistAdvertis(Request $request){

            ModelSaveAdvertis::where(['advertis_id' => $request['id'], 'users_id' => auth('customer')->id()])->delete();
            $data = \App\CPU\translate("Advertis has been remove from favorites");
            $wishlists = ModelSaveAdvertis::where('users_id', auth('customer')->id())->get();
            session()->put('wish_list_advertis', ModelSaveAdvertis::where('users_id', auth('customer')->user()->id)->pluck('advertis_id')->toArray());
            return response()->json([
                'success' => $data,
                'count' => count($wishlists),
                'id' => $request->id,
                'wishlist' => view('web-views.partials._wish-list-AdvertisData', compact('wishlists'))->render(),
            ]);
        }


        public function MyAdvertis()
        {
            $user = auth('customer')->user()->id;
            $Advertis = Advertis::with('Benefits', 'Skills', 'licenses', 'Languages', 'CareerSector', 'JobTitle', 'advertiseType',
            'educationDegree', 'typeContract', 'workDays', 'typeWorkHours', 'salary',  'experience', 'nationality', 'CityAdvertis',
            'StateAdvertis')->where('actor_type', 'App\Model\User')
            ->where('actor_id', $user)->get();


            $serch_value = '';

        return view('web-views.users-profile.MyAllAdvertisment', compact('Advertis', 'serch_value'), [
            'CareerSector' => CareerSector::select('id', 'name')->get(),
            'JobTitle' => JobTitle::select('id', 'name')->get(),
            'stateAdvertis' => StateAdvertis::select('id', 'name')->get(),
            'CityAdvertis' => CityAdvertis::select('id', 'name')->get(),
        ]);
        }
        public function search_Advert(Request $request)
        {
            $key = explode(' ', $request['name']);
            $Advertis = Advertis::where(function ($q) use ($key) {
                foreach ($key as $value) {
                    $q->orWhere('name', 'like', "%{$value}%");
                }
            })->where('status', 'Active')->get();


            $serch_value = $request->name;

            return view('web-views.users-profile.display', compact('Advertis', 'serch_value'), [
                'CareerSector' => CareerSector::select('id', 'name')->get(),
            'JobTitle' => JobTitle::select('id', 'name')->get(),
            'stateAdvertis' => StateAdvertis::select('id', 'name')->get(),
            'CityAdvertis' => CityAdvertis::select('id', 'name')->get(),
            ]);
        }

        public function search_MyAdvert(Request $request)
        {


            $key = explode(' ', $request['name']);
            $Advertis = Advertis::where(function ($q) use ($key) {
                foreach ($key as $value) {
                    $q->orWhere('name', 'like', "%{$value}%");
                }
            })->where('actor_type', 'App\Model\User')->where('actor_id', auth('customer')->id())->get();


            $serch_value = $request->name;

            return view('web-views.users-profile.MyAllAdvertisment', compact('Advertis', 'serch_value'), [
                'CareerSector' => CareerSector::select('id', 'name')->get(),
            'JobTitle' => JobTitle::select('id', 'name')->get(),
            'stateAdvertis' => StateAdvertis::select('id', 'name')->get(),
            'CityAdvertis' => CityAdvertis::select('id', 'name')->get(),
            ]);
        }

        public function fillterAdvertisement(Request $request){

            $serch_value = '';
            if(!$request->state_advertis == null && !$request->city_advertis == null && $request->career_sector == null && $request->job_title == null){

                    $Advertis = Advertis::where('state_advertis_id', $request->state_advertis)->where('city_advertis_id', $request->city_advertis)
                        ->where('status', 'Active')->paginate(15);
            }

            if(!$request->career_sector == null && !$request->job_title == null && $request->state_advertis == null && $request->city_advertis == null){

                    $Advertis = Advertis::where('career_sector_id', $request->career_sector)->where('job_title_id', $request->job_title)
                        ->where('status', 'Active')->paginate(15);

            }

            if(!$request->career_sector == null && !$request->job_title == null && !$request->state_advertis == null && !$request->city_advertis == null){

                $Advertis = Advertis::where('career_sector_id', $request->career_sector)->where('job_title_id', $request->job_title)
                    ->where('state_advertis_id', $request->state_advertis)->where('city_advertis_id', $request->city_advertis)
                    ->where('status', 'Active')->paginate(15);

            }

            return view('web-views.users-profile.display',compact('Advertis', 'serch_value'),[
                'CareerSector' => CareerSector::select('id', 'name')->get(),
                'JobTitle' => JobTitle::select('id', 'name')->get(),
                'stateAdvertis' => StateAdvertis::select('id', 'name')->get(),
                'cityAdvertis' => CityAdvertis::select('id', 'name','state_advertis_id')->get(),
            ]);
        }



        public function fillterMyAdvertisement(Request $request){


            if(!$request->state_advertis == null && !$request->city_advertis == null && $request->career_sector == null && $request->job_title == null){

                    $Advertis = Advertis::where('state_advertis_id', $request->state_advertis)->where('city_advertis_id', $request->city_advertis)
                    ->where('actor_type', 'App\Model\User')->where('actor_id', auth('customer')->id())->get();
            }

            if(!$request->career_sector == null && !$request->job_title == null && $request->state_advertis == null && $request->city_advertis == null){

                    $Advertis = Advertis::where('career_sector_id', $request->career_sector)->where('job_title_id', $request->job_title)
                    ->where('actor_type', 'App\Model\User')->where('actor_id', auth('customer')->id())->get();

            }

            if(!$request->career_sector == null && !$request->job_title == null && !$request->state_advertis == null && !$request->city_advertis == null){

                $Advertis = Advertis::where('career_sector_id', $request->career_sector)->where('job_title_id', $request->job_title)
                    ->where('state_advertis_id', $request->state_advertis)->where('city_advertis_id', $request->city_advertis)
                    ->where('actor_type', 'App\Model\User')->where('actor_id', auth('customer')->id())->get();

            }

            return view('web-views.users-profile.MyAllAdvertisment',compact('Advertis'),[
                'CareerSector' => CareerSector::select('id', 'name')->get(),
                'JobTitle' => JobTitle::select('id', 'name')->get(),
                'stateAdvertis' => StateAdvertis::select('id', 'name')->get(),
                'governorate' => Governorate::select('id', 'name')->get(),
            ]);
        }


        public function statusAdvertisement(Request $request){
            $Advertis = Advertis::findOrFail($request->id);
            $Advertis->status = ($Advertis['status'] == 'InActive') ? 'Active' : 'InActive';
            $Advertis->save();
            $data = $request->status;
            return response()->json($data);
        }

        public function deleteAdvertisement(Request $request){


            $translation = Translation::where('translationable_type','App\Model\Advertis')
                                        ->where('translationable_id', $request->id);
            $translation->delete();
            Advertis::destroy($request->id);

            return response()->json();

        }
        
        public function deleteAdvertis(Request $request){

            $Isdeleted = Advertis::where('id', $request->id)->first();

            $Isdeleted::destroy($request->id);

            return Toastr::success (\App\CPU\translate('deleted_Successfully_'));


        }


        public function disblay_Advertisement(Request $request, $id)
        {

            $business_mode=Helpers::get_business_settings('business_mode');

            $shop = Advertis::findOrFail($id);


            if( $shop->actor_type == 'App\Model\User'){
                $customerDetail = User::select('id','f_name','l_name','phone','image','temporary_token')->where('id',  $shop->actor_id)->first();
                $customerDetail->name = $customerDetail->f_name.' '.$customerDetail->l_name; 
            }else{
                $customerDetail = Admin::select('id','name','phone','image')->where('id',  $shop->actor_id)->first(); 
            }
            // if (auth('customer')->check()) {
            //     $customerDetail = User::where('id', auth('customer')->id())->first();

            // }


            return view('web-views.users-profile.shop_adversment',compact('shop', 'customerDetail'));
        }
        // public function search_jop(Request $request)
        // {
        //     $key = explode(' ', $request['name']);
        //     $Advertis = Advertis::where(function ($q) use ($key) {
        //         foreach ($key as $value) {
        //             $q->orWhere('name', 'like', "%{$value}%");
        //         }
        //     })->paginate(30);
        //     return view('web-views.users-profile.display', compact('Advertis'));
        // }
    public function fillterAdvertisement_API(Request $request)
    {
            // state_advertis // id
            // city_advertis // id
            // career_sector // id
            // job_title // id

            $Advertis1 = Advertis::where('status', 'Active');
        
            if(!$request->state_advertis == null && !$request->city_advertis == null && $request->career_sector == null && $request->job_title == null){

                $Advertis = $Advertis1->where('state_advertis_id', $request->state_advertis)->where('city_advertis_id', $request->city_advertis)
                    ;}
                

        if(!$request->career_sector == null && !$request->job_title == null && $request->state_advertis == null && $request->city_advertis == null){

                $Advertis = $Advertis1-> where('career_sector_id', $request->career_sector)->where('job_title_id', $request->job_title)
                ;}
        if(!$request->career_sector == null && !$request->job_title == null && !$request->state_advertis == null && !$request->city_advertis == null){

            $Advertis = $Advertis1-> where('career_sector_id', $request->career_sector)->where('job_title_id', $request->job_title)
                ->where('state_advertis_id', $request->state_advertis)->where('city_advertis_id', $request->city_advertis)
                ;}

        
                    $Advertis =  $Advertis1->get();
                    $data = [];
                    foreach($Advertis as $Advertisement ){
                            $newArray=[];
                            $newArray['id'] = $Advertisement->id;
                            $newArray['name'] = $Advertisement->name;
                            $newArray['description'] = $Advertisement->description;
                            $newArray['image'] = $Advertisement->image;                       
                            $newArray['careerSector'] = $Advertisement->CareerSector->name;
                            $newArray['jobTitle'] = $Advertisement->JobTitle->name;
                            $newArray['advertiserType'] = $Advertisement->advertiseType->name;
                            $newArray['educationDegree'] = $Advertisement->educationDegree->name;
                            $newArray['experienceLevel'] = $Advertisement->experience->experiences_level;
                            $newArray['extraBenefit'] = $Advertisement->benefits;
                            $newArray['skills'] = $Advertisement->Skills;
                            $newArray['languages'] = $Advertisement->Languages;
                            $newArray['contractType'] = $Advertisement->typeContract->name;   
                            $newArray['workFromHome'] = $Advertisement->work_from_home;
                            $newArray['workDays'] = $Advertisement->workDays->workDays;
                            $newArray['workHours'] = $Advertisement->typeWorkHours->name;
                            $newArray['jobRequiresVehicle'] = $Advertisement->job_requires_vehicle;
                            $newArray['requireDriverLicense'] = $Advertisement->Require_driver_license;
                            $newArray['licenses'] = $Advertisement->licenses;  
                            $newArray['nationality'] = $Advertisement->nationality->name;
                            $newArray['gender'] = $Advertisement->gender;
                            $newArray['expectedSalary'] = $Advertisement->expected_salary;
                            $newArray['salaryCurrency'] = $Advertisement->salary->type;  
                            $newArray['stateAdvertis'] = $Advertisement->StateAdvertis->name;
                            $newArray['cityAdvertis'] = $Advertisement->CityAdvertis->name;
                            $newArray['governorate'] = $Advertisement->governorate->name;                               
                            $newArray['status'] = $Advertisement->status;
                            $newArray['created_at'] = $Advertisement->created_at;
                            $newArray['updated_at'] = $Advertisement->updated_at;
                            if( $Advertisement->actor_type == 'App\Model\User'){
                                $newArray['actorDetail'] = User::select('id',DB::raw(' CONCAT(f_name," ",l_name) AS name'),'phone','image')->where('id',  $Advertisement->actor_id)->first(); 
                            }else{
                                $newArray['actorDetail'] = Admin::select('id','name','phone','image')->where('id',  $Advertisement->actor_id)->first(); 
                            }
                            array_push($data , $newArray);
                            }
                
                
                    
                    return response()->json([
                    'Advertis' => $data,
                
                    ]);
    }
        
    public function MyAdvertisAPI(Request $request)
    {
        $user = $request->user()->id;
        $Advertis = Advertis::where('actor_type', 'App\Model\User')
        ->where('actor_id', $user)->get();
        $data = [];
        foreach($Advertis as $Advertisement ){
                $newArray=[];
                $newArray['id'] = $Advertisement->id;
                $newArray['name'] = $Advertisement->name;
                $newArray['description'] = $Advertisement->description;
                $newArray['image'] = $Advertisement->image;    
                    
                $newArray['careerSector'] = $Advertisement->CareerSector->name;
                $newArray['jobTitle'] = $Advertisement->JobTitle->name;
                $newArray['advertiserType'] = $Advertisement->advertiseType->name;
                $newArray['educationDegree'] = $Advertisement->educationDegree->name;
                $newArray['experienceLevel'] = $Advertisement->experience->experiences_level;
                $newArray['extraBenefit'] = $Advertisement->benefits;
                $newArray['skills'] = $Advertisement->Skills;
                $newArray['languages'] = $Advertisement->Languages;
                $newArray['contractType'] = $Advertisement->typeContract->name;

                $newArray['workFromHome'] = $Advertisement->work_from_home;
                $newArray['workDays'] = $Advertisement->workDays->workDays;
                $newArray['workHours'] = $Advertisement->typeWorkHours->name;
                $newArray['jobRequiresVehicle'] = $Advertisement->job_requires_vehicle;
                $newArray['requireDriverLicense'] = $Advertisement->Require_driver_license;
                $newArray['licenses'] = $Advertisement->licenses;

                $newArray['nationality'] = $Advertisement->nationality->name;
                $newArray['gender'] = $Advertisement->gender;
                $newArray['expectedSalary'] = $Advertisement->expected_salary;
                $newArray['salaryCurrency'] = $Advertisement->salary->type;

                $newArray['stateAdvertis'] = $Advertisement->StateAdvertis->name;
                $newArray['cityAdvertis'] = $Advertisement->CityAdvertis->name;
                $newArray['governorate'] = $Advertisement->governorate->name;
                            

                $newArray['status'] = $Advertisement->status;
                $newArray['created_at'] = $Advertisement->created_at;
                $newArray['updated_at'] = $Advertisement->updated_at;
                $newArray['actorDetail'] = User::select('id',DB::raw(' CONCAT(f_name," ",l_name) AS name'),'phone','image')->where('id',  $Advertisement->actor_id)->first(); 
                array_push($data , $newArray);
                }

        return response()->json([
        'Advertis' => $data,

        ]);
    }

        public function search_MyAdvertAPI(Request $request)
        {
            $key = explode(' ', $request['name']);
            $Advertis = Advertis::where('actor_type', 'App\Model\User')->where(function ($q) use ($key) {
                foreach ($key as $value) {
                    $q->orWhere('name', 'like', "%{$value}%");
                }
            })->get();
            $data = [];
            foreach($Advertis as $Advertisement ){
                    $newArray=[];
                    $newArray['id'] = $Advertisement->id;
                    $newArray['name'] = $Advertisement->name;
                    $newArray['description'] = $Advertisement->description;
                    $newArray['image'] = $Advertisement->image;    
                        
                    $newArray['careerSector'] = $Advertisement->CareerSector->name;
                    $newArray['jobTitle'] = $Advertisement->JobTitle->name;
                    $newArray['advertiserType'] = $Advertisement->advertiseType->name;
                    $newArray['educationDegree'] = $Advertisement->educationDegree->name;
                    $newArray['experienceLevel'] = $Advertisement->experience->experiences_level;
                    $newArray['extraBenefit'] = $Advertisement->benefits;
                    $newArray['skills'] = $Advertisement->Skills;
                    $newArray['languages'] = $Advertisement->Languages;
                    $newArray['contractType'] = $Advertisement->typeContract->name;
        
                    $newArray['workFromHome'] = $Advertisement->work_from_home;
                    $newArray['workDays'] = $Advertisement->workDays->workDays;
                    $newArray['workHours'] = $Advertisement->typeWorkHours->name;
                    $newArray['jobRequiresVehicle'] = $Advertisement->job_requires_vehicle;
                    $newArray['requireDriverLicense'] = $Advertisement->Require_driver_license;
                    $newArray['licenses'] = $Advertisement->licenses;
        
                    $newArray['nationality'] = $Advertisement->nationality->name;
                    $newArray['gender'] = $Advertisement->gender;
                    $newArray['expectedSalary'] = $Advertisement->expected_salary;
                    $newArray['salaryCurrency'] = $Advertisement->salary->type;
        
                    $newArray['stateAdvertis'] = $Advertisement->StateAdvertis->name;
                    $newArray['cityAdvertis'] = $Advertisement->CityAdvertis->name;
                    $newArray['governorate'] = $Advertisement->governorate->name;
                                
        
                    $newArray['status'] = $Advertisement->status;
                    $newArray['created_at'] = $Advertisement->created_at;
                    $newArray['updated_at'] = $Advertisement->updated_at;
                    $newArray['actorDetail'] = User::select('id',DB::raw(' CONCAT(f_name," ",l_name) AS name'),'image')->where('id',  $Advertisement->actor_id)->first(); 
                    array_push($data , $newArray);
                    }




    
            $serch_value = $request->name;
            return response()->json([
            'Advertis' => $data,
            'serch_value' => $serch_value,         
            ]);
        }
    public function search_AdvertAPI(Request $request)
    {
        

        $key = explode(' ', $request['name']);
        $Advertis = Advertis::where('status', 'Active')->where(function ($q) use ($key) {
        foreach ($key as $value) {
        $q->orWhere('name', 'like', "%{$value}%");
        }
        })->get();
        $data = [];
        foreach($Advertis as $Advertisement ){
                $newArray=[];
                $newArray['id'] = $Advertisement->id;
                $newArray['name'] = $Advertisement->name;
                $newArray['description'] = $Advertisement->description;
                $newArray['image'] = $Advertisement->image;                     
                $newArray['careerSector'] = $Advertisement->CareerSector->name;
                $newArray['jobTitle'] = $Advertisement->JobTitle->name;
                $newArray['advertiserType'] = $Advertisement->advertiseType->name;
                $newArray['educationDegree'] = $Advertisement->educationDegree->name;
                $newArray['experienceLevel'] = $Advertisement->experience->experiences_level;
                $newArray['extraBenefit'] = $Advertisement->benefits;
                $newArray['skills'] = $Advertisement->Skills;
                $newArray['languages'] = $Advertisement->Languages;
                $newArray['contractType'] = $Advertisement->typeContract->name;
                $newArray['workFromHome'] = $Advertisement->work_from_home;
                $newArray['workDays'] = $Advertisement->workDays->workDays;
                $newArray['workHours'] = $Advertisement->typeWorkHours->name;
                $newArray['jobRequiresVehicle'] = $Advertisement->job_requires_vehicle;
                $newArray['requireDriverLicense'] = $Advertisement->Require_driver_license;
                $newArray['licenses'] = $Advertisement->licenses;
                $newArray['nationality'] = $Advertisement->nationality->name;
                $newArray['gender'] = $Advertisement->gender;
                $newArray['expectedSalary'] = $Advertisement->expected_salary;
                $newArray['salaryCurrency'] = $Advertisement->salary->type;
                $newArray['stateAdvertis'] = $Advertisement->StateAdvertis->name;
                $newArray['cityAdvertis'] = $Advertisement->CityAdvertis->name;
                $newArray['governorate'] = $Advertisement->governorate->name;
                $newArray['status'] = $Advertisement->status;
                $newArray['created_at'] = $Advertisement->created_at;
                $newArray['updated_at'] = $Advertisement->updated_at;
                if( $Advertisement->actor_type == 'App\Model\User'){
                    $newArray['actorDetail'] = User::select('id',DB::raw(' CONCAT(f_name," ",l_name) AS name'),'phone','image')->where('id',  $Advertisement->actor_id)->first(); 
                }else{
                    $newArray['actorDetail'] = Admin::select('id','name','phone','image')->where('id',  $Advertisement->actor_id)->first(); 
                }
                array_push($data , $newArray);
                }


    
        $serch_value = $request->name;
        return response()->json([
        'Advertis' => $data,
        'serch_value' => $serch_value,
        ]);
        }
        public function wishlistsAdvertismentApi(Request $request) // user token 
        {
            $wishlists = ModelSaveAdvertis::whereHas('wishlistAdvertis', function ($q) {
                return $q;
            })->where('users_id', $request->user()->id)->get();
            

        $data = [];
            foreach($wishlists as $Advertisement2 ){

                $Advertis =Advertis::where('id', $Advertisement2->advertis_id)->get();
            
        

                foreach($Advertis as $Advertisement ){
        
                $newArray=[];
                $newArray['id'] = $Advertisement->id;
                $newArray['name'] = $Advertisement->name;
                $newArray['description'] = $Advertisement->description;
                $newArray['image'] = $Advertisement->image;                     
                $newArray['careerSector'] = $Advertisement->CareerSector->name;
                $newArray['jobTitle'] = $Advertisement->JobTitle->name;
                $newArray['advertiserType'] = $Advertisement->advertiseType->name;
                $newArray['educationDegree'] = $Advertisement->educationDegree->name;
                $newArray['experienceLevel'] = $Advertisement->experience->experiences_level;
                $newArray['extraBenefit'] = $Advertisement->benefits;
                $newArray['skills'] = $Advertisement->Skills;
                $newArray['languages'] = $Advertisement->Languages;
                $newArray['contractType'] = $Advertisement->typeContract->name;
                $newArray['workFromHome'] = $Advertisement->work_from_home;
                $newArray['workDays'] = $Advertisement->workDays->workDays;
                $newArray['workHours'] = $Advertisement->typeWorkHours->name;
                $newArray['jobRequiresVehicle'] = $Advertisement->job_requires_vehicle;
                $newArray['requireDriverLicense'] = $Advertisement->Require_driver_license;
                $newArray['licenses'] = $Advertisement->licenses;
                $newArray['nationality'] = $Advertisement->nationality->name;
                $newArray['gender'] = $Advertisement->gender;
                $newArray['expectedSalary'] = $Advertisement->expected_salary;
                $newArray['salaryCurrency'] = $Advertisement->salary->type;
                $newArray['stateAdvertis'] = $Advertisement->StateAdvertis->name;
                $newArray['cityAdvertis'] = $Advertisement->CityAdvertis->name;
                $newArray['governorate'] = $Advertisement->governorate->name;
                $newArray['status'] = $Advertisement->status;
                $newArray['created_at'] = $Advertisement->created_at;
                $newArray['updated_at'] = $Advertisement->updated_at;
                if( $Advertisement->actor_type == 'App\Model\User'){
                    $newArray['actorDetail'] = User::select('id',DB::raw(' CONCAT(f_name," ",l_name) AS name'),'phone','image')->where('id',  $Advertisement->actor_id)->first(); 
                }else{
                    $newArray['actorDetail'] = Admin::select('id','name','phone','image')->where('id',  $Advertisement->actor_id)->first(); 
                }
                array_push($data , $newArray);
                }

            }

            return response()->json([
                'count' => count($wishlists),
                'wishlist' => $wishlists,
                'Advertis'=>$data
            ]);
        }
    public function deleteWishlistAdvertisApi(Request $request) // id ad d
    {

            ModelSaveAdvertis::where(['advertis_id' => $request->id, 'users_id' => $request->user()->id])->delete();
            $data = \App\CPU\translate("Advertis has been remove from favorites");
            $wishlists = ModelSaveAdvertis::where('users_id', $request->user()->id)->get();
            // session()->put('wish_list_advertis', ModelSaveAdvertis::where('users_id', auth('customer')->user()->id)->pluck('advertis_id')->toArray());
            return response()->json([
                'success' => $data,
                'count' => count($wishlists),
                'wishlist' => $wishlists,
            ]);
    }


    public function deleteMyAd(Request $request) // need id add and user token 
    {
        $msg= \App\CPU\translate("Your ad has been successfully deleted");
            $user = $request->user()->id;
            $Advertis = Advertis::where('id', $request->id)->where('actor_id', $user)->delete();
            return response()->json(['msg' => $msg]);
    }
    public function addtofavorate(Request $request)
    {//id addv

            $wishlist = ModelSaveAdvertis::where('users_id',  $request->user()->id)->where('advertis_id', $request->advertis_id)->first();
            if (empty($wishlist)) {

                $wishlist = new ModelSaveAdvertis;
                $wishlist->users_id =  $request->user()->id;
                $wishlist->advertis_id = $request->advertis_id;
                $wishlist->save();

                $countWishlist = ModelSaveAdvertis::whereHas('wishlistAdvertis',function($q){
                    return $q;
                })->where('users_id',  $request->user()->id)->get();

                $data = \App\CPU\translate("Ad added to favourites");

                $Advertis_count = ModelSaveAdvertis::where(['advertis_id' => $request->advertis_id])->count();
                session()->put('wish_list_advertis', ModelSaveAdvertis::where('users_id',  $request->user()->id)->pluck('advertis_id')->toArray());
                return response()->json(['success' => $data, 'value' => 1, 'count' => count($countWishlist), 'id' => $request->advertis_id, 'Advertis_count' => $Advertis_count]);
            } else {
                $data = \App\CPU\translate("This ad has already been added to your favourites");
                return response()->json(['error' => $data, 'value' => 2]);
            }

    

    }



}
 
