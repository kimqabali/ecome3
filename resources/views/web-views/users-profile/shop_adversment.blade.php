@extends('layouts.front-end.app')

@section('title', \App\CPU\translate('show_advertism_detail'))

@push('css_or_js')
    <link href="{{ asset('public/assets/front-end')}}/css/home.css" rel="stylesheet">
    <style>

        .headerTitle {
            font-size: 25px;
            font-weight: bolder;
            margin-top: 3rem;
            text-align: center;
            color: rgb(19, 71, 51)
        }

        .page-item.active .page-link {
            background-color: {{ $web_config['primary_color'] }} !important;
        }

        .page-item.active>.page-link {
            box-shadow: 0 0 black !important;
        }

        /***********************************/
        .sidepanel {
            width: 0;
            position: fixed;
            z-index: 6;
            height: 500px;
            top: 0;
            left: 0;
            background-color: #ffffff;
            overflow-x: hidden;
            transition: 0.5s;
            padding-top: 40px;
        }

        .sidepanel a {
            padding: 8px 8px 8px 32px;
            text-decoration: none;
            font-size: 25px;
            color: #818181;
            display: block;
            transition: 0.3s;
        }

        .sidepanel a:hover {
            color: #f1f1f1;
        }

        .sidepanel .closebtn {
            position: absolute;
            top: 0;
            right: 0px;
            font-size: 36px;
        }

        .openbtn {
            font-size: 18px;
            cursor: pointer;
            background-color: #ffffff;
            color: #373f50;
            width: 40%;
            border: none;
        }

        .openbtn:hover {
            background-color: #444;
        }

        .for-display {
            display: block !important;
        }

        @media (max-width: 360px) {
            .openbtn {
                width: 59%;
            }

            .for-shoting-mobile {
                margin-right: 0% !important;
            }

            .for-mobile {

                margin-left: 10% !important;
            }

        }

        @media screen and (min-width: 375px) {

            .for-shoting-mobile {
                margin-right: 7% !important;
            }

            .custom-select {
                width: 86px;
            }


        }

        @media (max-width: 500px) {
            .for-mobile {

                margin-left: 27%;
            }
            .advertis-view-body .advertis-view-body-p {

                margin: 0;
                font-size: 15px;
                background-color:#f1f1f1
                
            }
            .openbtn:hover {
                background-color: #fff;
            }

            .for-display {
                display: flex !important;
            }

            .for-shoting-mobile {
                margin-right: 11%;
            }

            .for-tab-display {
                display: none !important;
            }

            .openbtn-tab {
                margin-top: 0 !important;
            }

            .seller-details {
                justify-content: center !important;
                padding-bottom: 8px;
            }

        }

        @media screen and (min-width: 500px) {
            .openbtn {
                display: none !important;
            }


        }

        @media screen and (min-width: 800px) {


            .for-tab-display {
                display: none !important;
            }

        }

        @media (max-width: 768px) {
            .headerTitle {
                font-size: 23px;

            }

            .openbtn-tab {
                margin-top: 3rem;
                display: inline-block !important;
            }

            .for-tab-display {
                display: inline;
            }

        }
        @media  (max-width: 768px) {
            .testmedia{
                display: flex !important;
                flex-wrap: wrap;
                align-items: center;
                align-content: center;
                flex-direction: column-reverse;
                justify-content: center
            }
            .abd-center{
                text-align: center;
            }
        }
    </style>
@endpush

@section('content')

    <div class="container rtl" style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};">
        <h1 class="h3  mb-0 text-center headerTitle">{{\App\CPU\translate('job advertisement')}}<span><p style="color: red">{{ $shop->name }}</p></span></h1>

    </div>
    <div class="container rtl d-flex testmedia align-items-center justify-content-between">
        <div>
            @if (\App\Model\SaveAdvertis::where('users_id', auth('customer')->id())->where('advertis_id', $shop->id)->exists())

            <button type="button" onclick="addWishlistAdvertis('{{ $shop['id'] }}')"
                class="btn"
                style="color:{{ $web_config['secondary_color'] }};font-size: 18px;">
                <i class="fa fa-heart" aria-hidden="true"></i>
            </button><br>

            @else
            <button type="button" onclick="addWishlistAdvertis('{{ $shop['id'] }}')"
                class="btn click-heart"
                style="color:{{ $web_config['secondary_color'] }};font-size: 18px;">
                <i class="fa fa-heart-o" onclick="changeClass()" aria-hidden="true"></i>
            </button><br>
            @endif
            

       


        </div>

        <div class="container rtl abd-center">
            <div class="topbar-text dropdown d-md-none {{ Session::get('direction') === 'rtl' ? 'mr-auto' : 'ml-auto' }}">
            <a class="topbar-link btn btn-info btn-sm" href="tel: {{  $customerDetail->phone ?? '' }}"><i class="fa fa-phone"></i>{{  $customerDetail->phone ?? '' }}</a>
            </div>
            <div class="d-none d-md-block {{ Session::get('direction') === 'rtl' ? 'mr-2' : 'mr-2' }} text-nowrap">
            <a class="topbar-link d-none d-md-inline-block btn btn-info btn-sm" href="tel:{{ $customerDetail->phone ?? '' }}"><i class="fa fa-phone"></i>{{ $customerDetail->phone ?? '' }}</a>
            </div>
        </div>
        <div class="d-flex testmedia mb-3 mb-md-0 align-items-center">
            <h5 class="font-name"style="text-align:justify; margin-left: 11px;">{{$customerDetail->name ?? ''}}</h5>
            <img id="blah"
                class="rounded-circle border __inline-48"
                onerror="this.src='{{asset('public/assets/front-end/img/image-place-holder.png')}}'"
                src="{{asset('storage/app/public/profile')}}/{{$customerDetail['image']}}" style=" margin-right:3px;"><br>
                
        </div>

    </div>
  


<div class="d-flex mb-3 mb-md-1 align-items-center">
<div class="container rtl">
<div class="col-md-9"
style="margin-right: 10px;position: relative;text-align:center;text-align: right; position: absolute;right:7%;">
<span
    style="font-weight: 400;"class=" font-for-tab d-inline-block font-size-sm text-body align-middle mt-1 {{ Session::get('direction') === 'rtl' ? 'mr-1 ml-md-2 ml-0 pr-md-2 pr-sm-1 pl-md-2 pl-sm-1' : 'ml-1 mr-md-2 mr-0 pl-md-2 pl-sm-1 pr-md-2 pr-sm-1' }} text-capitalize">
</span>


</div>
</div>
</div>




<div class="container pb-5 mb-2 mb-md-4 mt-3 rtl"  style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};">
    <div class="card-body">
        <section class="bg-transparent mb-3">
            <div class="container">
                <div class="row ">
                    <div class="col-12">
                        <div class="row rtl justify-content-around">
                            <!-- <div class="col-xl-3 d-none d-xl-block __top-slider-cate">
                                <div ></div>
                            </div> -->

                            <div class="col-xl-12 col-md-12 __top-slider-images" style="{{Session::get('direction') === "rtl" ? 'margin-top: 3px;padding-right:10px;' : 'margin-top: 3px; padding-left:10px;'}}">
                                @php($main_banner=\App\Model\Banner::where('banner_type','Main Banner')->where('published',1)->orderBy('id','desc')->get())
                                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                                    <ol class="carousel-indicators">
                                        @foreach($shop->image as $key=>$imgAdvertis)
                                            <li data-target="#carouselExampleIndicators" data-slide-to="{{$key}}"
                                                class="{{$key==0?'active':''}}">
                                            </li>
                                        @endforeach
                                    </ol>
                                    <div class="carousel-inner">
                                        {{-- @foreach($shop->image as $imgAdvertis)
                                            <div class="carousel-item">
                                                <a href="">
                                                    <img class="d-block w-100 __slide-img"
                                                         onerror="this.src='{{asset('public/assets/front-end/img/image-place-holder.png')}}'"
                                                         src="{{asset('public/uploads/'.$imgAdvertis)}}" alt="">
                                                </a>
                                            </div>
                                        @endforeach --}}
                                        @foreach($shop->image as $key=>$banner)
                                            <div class="carousel-item {{$key==0?'active':''}}">
                                                <a href="">
                                                    <img class="d-block w-100 __slide-img"
                                                        onerror="this.src='{{asset('public/assets/front-end/img/image-place-holder.png')}}'"
                                                        src="{{asset('public/uploads/'.$imgAdvertis)}}"
                                                        alt="">
                                                </a>
                                            </div>
                                        @endforeach

                                        <div class="carousel-item">
                                            <a href="">
                                                <img class="d-block w-100 __slide-img"
                                                     onerror="this.src='{{asset('public/assets/front-end/img/image-place-holder.png')}}'"
                                                     src="{{asset('public/uploads/FmsiHtPElFDiLVr806zcFiB8hkjcqRPkHZKcfkzp.png')}}" alt="">
                                            </a>
                                        </div>
                                        <div class="carousel-item">
                                            <a href="">
                                                <img class="d-block w-100 __slide-img"
                                                     onerror="this.src='{{asset('public/assets/front-end/img/image-place-holder.png')}}'"
                                                     src="{{asset('public/uploads/lKNGQbUWs2tTmtZS5bA6IrOMQMqXDWcvD6mfpGNL.png')}}" alt="">
                                            </a>
                                        </div>
                                        <div class="carousel-item">
                                            <a href="">
                                                <img class="d-block w-100 __slide-img"
                                                     onerror="this.src='{{asset('public/assets/front-end/img/image-place-holder.png')}}'"
                                                     src="{{asset('public/uploads/OAAAChMsQErkts3J61g9gL0rf6uhpZnUEmaYvQnA.png')}}" alt="">
                                            </a>
                                        </div>
                                    </div>
                                    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button"
                                       data-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true" ></span>
                                        <span class="sr-only">{{\App\CPU\translate('Previous')}}</span>
                                    </a>
                                    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button"
                                       data-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="sr-only">{{\App\CPU\translate('Next')}}</span>
                                    </a>
                                </div>


                            </div>
                            <!-- Banner group-->
                        </div>


                        <script>
                            $(function () {
                                $('.list-group-item').on('click', function () {
                                    $('.glyphicon', this)
                                        .toggleClass('glyphicon-chevron-right')
                                        .toggleClass('glyphicon-chevron-down');
                                });
                            });
                        </script>

                    </div>
                </div>
            </div>
        </section>
        {{-- <div class=""><br>
            @if($shop['id'] != 0)
                <img style="max-height: 115px;width:120px; border-radius: 5px;"
                     src="{{asset('storage/app/public/shop')}}/{{$shop->photo}}"
                     onerror="this.src='{{asset('public/assets/front-end/img/image-place-holder.png')}}'"
                     alt="">
            @else
                <img style="height: 120px;width:120px; border-radius: 5px;"
                     src="{{asset('storage/app/public/company')}}/{{$web_config['fav_icon']->value}}"
                     onerror="this.src='{{asset('public/assets/front-end/img/image-place-holder.png')}}'"
                     alt="">
            @endif
        </div> --}}

    <table id="dataTable" style="text-align: {{ Session::get('direction') === 'rtl' ? 'right' : 'left' }};"
        class="table table-bordered table-hover" width="100%" cellspacing="0" >


            <tr>
                <td class="width50"> {{ \App\CPU\translate('description') }} </td>
                <td class="width50"> {!! $shop['description'] !!}</td>
            </tr>
            <tr>
                <td class="width50"> {{ \App\CPU\translate('career_sector_and_job_title') }} </td>
                <td> <p class="advertis-view-body-p" style="color: rebeccapurple">
                 <button class=" border btn-sm">{{ $shop->CareerSector->name }}</button> <button class="border btn-sm">{{ $shop->JobTitle->name }}</button> </p> 
                </td>
            </tr>
            <tr>
            <td class="width50"> {{ \App\CPU\translate('education_degree_and_experience') }} </td>
                <td> <p class="advertis-view-body-p" style="color: rebeccapurple">
                 <button class=" border btn-sm">{{ $shop->educationDegree->name }}</button> <button class="border btn-sm">{{ $shop->experience->experiences_level }}</button> </p> 
                </td>
            </tr>
            <tr>
                <td class="width30">{{ \App\CPU\translate('extra_benefit') }}</td>
                <td class="width30"> @foreach($shop->Benefits as $name)
                <p class="advertis-view-body-p" style="color: rebeccapurple">
                 <button class=" border btn-sm">{{ $name->name }}</button> </p> 
                @endforeach</td>
            </tr>
            @if(!$shop->Skills==null)
                <tr>
                <td class="width30">{{ \App\CPU\translate('skill_') }}</td>

                <td class="width30"> @forelse($shop->Skills as $name)
                <p class="advertis-view-body-p" style="color: rebeccapurple">
                 <button class=" border btn-sm">  {{$name->name }}

                     @empty
                        </button> </p> 
                @endforelse</td>
                </tr>
           
            @endif
            @if(!$shop->Languages==null)
            <tr>
                <td class="width30">{{ \App\CPU\translate('language_') }}</td>
                <td class="width30"> @forelse($shop->Languages as $name)
                <p class="advertis-view-body-p" style="color: rebeccapurple">
                 <button class=" border btn-sm">  {{$name->name }}
                 @empty
                   </button> </p> 
                @endforelse</td>
            </tr>
            @endif
            <tr>
                <td class="width50">{{ \App\CPU\translate('advertise_type') }}</td>
                <td class="width50">{{ $shop->advertiseType->name}}</td>
            </tr>
           
            <tr>

                <td class="width50">{{ \App\CPU\translate('type_contract') }}</td>
                <td class="width50">{{ $shop->typeContract->name }} </td>
            </tr>
            <tr>

                <td class="width50">{{ \App\CPU\translate('work_day') }}</td>
                <td class="width50">{{ $shop->workDays->workDays }} </td>
            </tr>
            <tr>
                <td class="width30">{{ \App\CPU\translate('work_hour') }} </td>
                <td class="width50">{{ $shop->typeWorkHours->name }}</td>
            </tr>
            <tr>
                <td class="width50">{{ \App\CPU\translate('Work_from_home') }} </td>
                <td class="width50">{{ $shop->work_from_home }}</td>

            </tr>
            <tr>
                <td class="width50">{{ \App\CPU\translate('The_job_requires_a_vehicle') }} </td>
                <td class="width50">{{ $shop->job_requires_vehicle }}</td>
            </tr>
            <tr>
                <td class="width50">{{ \App\CPU\translate('Driving_license_required') }}</td>
                <td class="width50">{{ $shop->Require_driver_license }}</td>
            </tr>
            @if(!$shop->licenses==null)
            <tr>
                <td class="width30">{{ \App\CPU\translate('License_category') }}</td>
                <td class="width30"> @forelse($shop->licenses as $name)
                <p class="advertis-view-body-p" style="color: rebeccapurple">
                 <button class=" border btn-sm">  {{$name->name }}
                 @empty
                    </button> </p> 
                @endforelse</td> 
            </tr>
            @endif

            @if(!$shop->expected_salary==null && !$shop->salary==null)
            <tr>
                <td class="width50">{{ \App\CPU\translate('salary') }}</td>
                <td class="width30">{{$shop->expected_salary ?? \App\CPU\translate('undefined')}} {{$shop->salary->type}} </td>
            </tr>
            @endif
            <tr>
                <td class="width50">{{ \App\CPU\translate('nationality') }} </td>
                <td class="width50">{{ $shop->nationality->name }}</td>
            </tr>
            <tr>
                <td class="width50">{{ \App\CPU\translate('sex') }} </td>
                <td class="width50">{{ $shop->gender }}</td>
            </tr>
            <tr>
                <td class="width50"> {{ \App\CPU\translate('ADDRESSE') }} </td>
                <td> <p class="advertis-view-body-p" style="color: rebeccapurple">
                 <a><button class=" border btn-sm">{{ $shop->StateAdvertis->name }}</button></a> 
                 <a><button class="border btn-sm">{{ $shop->CityAdvertis->name }}</button></a> 
                 @empty(!$shop->Governorate->name)
                   <button class="border btn-sm">{{ $shop->Governorate->name }} </button>
                 @endempty
                  </p> 
                </td>
            </tr>
            <tr>
                <td class="width30">{{ \App\CPU\translate('ADDRESSE')}} </td>
                <td class="width30"> <a>{{$shop->Governorate->name  ??'' ,}}</a>  {{ $shop->CityAdvertis->name  }} , {{ $shop->StateAdvertis->name }}</td>
            </tr>
        

    </table>
    </div>
    </div>
    <div class="col-lg-12 rtl" style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};">
        <div style="border-radius:10px;background: #ffffff;{{Session::get('direction') === "rtl" ? 'padding-left:5px;' : 'padding-left:5px;'}}">
            <div class="row d-flex justify-content-between seller-details" style="">
    <div class="d-flex" style="padding:8px;">
        {{-- <div class="">
            @if($shop['id'] != 0)
                <img style="max-height: 115px;width:120px; border-radius: 5px;"
                     src="{{asset('storage/app/public/shop')}}/{{$shop->photo}}"
                     onerror="this.src='{{asset('public/assets/front-end/img/image-place-holder.png')}}'"
                     alt="">
            @else
                <img style="height: 120px;width:120px; border-radius: 5px;"
                     src="{{asset('storage/app/public/company')}}/{{$web_config['fav_icon']->value}}"
                     onerror="this.src='{{asset('public/assets/front-end/img/image-place-holder.png')}}'"
                     alt="">
            @endif
        </div> --}}
        {{-- <div class="row col-8 mx-1 align-items-center" style="display:inline-block;">
            <span class="ml-4 font-weight-bold ">
                @if($shop['id'] != 0)
                    {{ $shop->name}}
                @else
                    {{ $web_config['name']->value }}
                @endif
            </span>
            <div class="row ml-4 flex-start">
                <div class="mr-3">


                </div>

            </div>
        </div> --}}
    </div>

       {{-- Motal --}}
       <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
       aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="card-header">
                  {{\App\CPU\translate('write_something')}}
              </div>
              <div class="modal-body">
                  <form action="{{route('messages_store')}}" method="post" id="chat-form">
                      @csrf
                      @if($shop['id'] != 0)
                          <input value="{{$shop->id}}" name="id" hidden>
                          <input value="{{$shop->seller_id}}}" name="seller_id" hidden>
                      @endif

                      <textarea name="message" class="form-control" required></textarea>
                      <br>
                      @if($shop['id'] != 0)
                          <button class="btn btn-primary" style="color: white;">{{\App\CPU\translate('send')}}</button>
                      @else
                          <button class="btn btn-primary" style="color: white;" disabled>{{\App\CPU\translate('send')}}</button>
                      @endif
                  </form>
              </div>
              <div class="card-footer">
                  <a href="{{route('chat-with-seller')}}" class="btn btn-primary mx-1">
                      {{\App\CPU\translate('go_to')}} {{\App\CPU\translate('chatbox')}}
                  </a>
                  <button type="button" class="btn btn-secondary pull-right" data-dismiss="modal">{{\App\CPU\translate('close')}}
                  </button>
              </div>
          </div>
      </div>
  </div>
  </div>
  </div>
  </div>


@endsection


@push('script')
{{-- <!-- whatsapp text support widget by arabes1.com -->
<script type="text/javascript">
    (function () {
        var options = {
            whatsapp: " +972597852319", // WhatsApp number
            company_logo_url: "//static.whatshelp.io/img/flag.png", // URL of company logo (png, jpg, gif)
            greeting_message: "مرحبا، كيف يمكننا مساعدتك؟ فقط أرسل لنا رسالة الآن للحصول على المساعدة.", // Text of greeting message
            call_to_action: "رسالنا", // Call to action
            position: "right", // Position may be 'right' or 'left'
        };
        var proto = document.location.protocol, host = "whatshelp.io", url = proto + "//static." + host;
        var s = document.createElement('script'); s.type = 'text/javascript'; s.async = true; s.src = url + '/widget-send-button/js/init.js';
        s.onload = function () { WhWidgetSendButton.init(host, proto, options); };
        var x = document.getElementsByTagName('script')[0]; x.parentNode.insertBefore(s, x);
    })();
</script>
<!-- /whatsapp text support widget --> --}}
    <script>
        function productSearch(seller_id, category_id) {
            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                }
            });

            $.ajax({
                type: "post",
                url: '{{ url('/') }}/shopView/' + seller_id + '?category_id=' + category_id,

                beforeSend: function() {
                    $('#loading').show();
                },
                success: function(response) {
                    $('#ajax-products').html(response.view);
                },
                complete: function() {
                    $('#loading').hide();
                },
            });
        }
    </script>

    <script>
        function openNav() {

            document.getElementById("mySidepanel").style.width = "50%";
        }

        function closeNav() {
            document.getElementById("mySidepanel").style.width = "0";
        }
    </script>
    <script>

        function changeClass(){
            let heart = document.querySelector('.fa-heart-o');
            heart.className = "fa fa-heart";

        }
        function addWishlistAdvertis(advertis_id) {

        $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
            }
        });
        $.ajax({
            url: "{{route('saveAdvertisment')}}",
            method: 'POST',
            data: {
                advertis_id: advertis_id
            },
            success: function (data) {
                if (data.value == 1) {
                    Swal.fire({
                        position: 'top-end',
                        type: 'success',
                        title: data.success,
                        showConfirmButton: false,
                        timer: 1500
                    });
                    $('.tooltip').html('');

                } else if (data.value == 2) {
                    Swal.fire({
                        type: 'info',
                        title: 'WishList',
                        text: data.error
                    });
                } else {
                    Swal.fire({
                        type: 'error',
                        title: 'WishList',
                        text: data.error
                    });
                }
            }
        });
    }
    </script>
    <script>
        $('#chat-form').on('submit', function(e) {
            e.preventDefault();

            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                }
            });

            $.ajax({
                type: "post",
                url: '{{ route('messages_store') }}',
                data: $('#chat-form').serialize(),
                success: function(respons) {

                    toastr.success('{{ \App\CPU\translate('send successfully') }}', {
                        CloseButton: true,
                        ProgressBar: true
                    });
                    $('#chat-form').trigger('reset');
                }
            });

        });
    </script>
 <script>
        function featured_status(id) {
            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                }
            });
            $.ajax({
                url: "{{ route('saveAdvertisment') }}",
                method: 'PUT',
                data: {
                    id: id
                },
                success: function() {
                    toastr.success('{{ \App\CPU\translate('advertisment status updated successfully') }}');
                }
            });
        }
    </script>

@endpush
