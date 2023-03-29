@extends('layouts.front-end.app')

@section('title', \App\CPU\translate('show_advertisment'))

@push('css_or_js')
    <meta property="og:image" content="{{ asset('storage/app/public/company') }}/{{ $web_config['web_logo'] }}" />
    <meta property="og:title" content="Products of {{ $web_config['name'] }} " />
    <meta property="og:url" content="{{ env('APP_URL') }}">
    <meta property="og:description" content="{!! substr($web_config['about']->value, 0, 100) !!}">

    <meta property="twitter:card" content="{{ asset('storage/app/public/company') }}/{{ $web_config['web_logo'] }}" />
    <meta property="twitter:title" content="Products of {{ $web_config['name'] }}" />
    <meta property="twitter:url" content="{{ env('APP_URL') }}">
    <meta property="twitter:description" content="{!! substr($web_config['about']->value, 0, 100) !!}">

    <style>
        .headerTitle {
            font-size: 26px;
            font-weight: bolder;
            margin-top: 3rem;
        }

        .for-count-value {
            position: absolute;

            {{ Session::get('direction') === 'rtl' ? 'left' : 'right' }}: 0.6875 rem;
            ;
            width: 1.25rem;
            height: 1.25rem;
            border-radius: 50%;

            color: black;
            font-size: .75rem;
            font-weight: 500;
            text-align: center;
            line-height: 1.25rem;
        }

        .for-count-value {
            position: absolute;

            {{ Session::get('direction') === 'rtl' ? 'left' : 'right' }}: 0.6875 rem;
            width: 1.25rem;
            height: 1.25rem;
            border-radius: 50%;
            color: #fff;
            font-size: 0.75rem;
            font-weight: 500;
            text-align: center;
            line-height: 1.25rem;
        }

        .for-brand-hover:hover {
            color: {{ $web_config['primary_color'] }};
        }

        .for-hover-lable:hover {
            color: {{ $web_config['primary_color'] }} !important;
        }

        .page-item.active .page-link {
            background-color: {{ $web_config['primary_color'] }} !important;
        }

        .page-item.active>.page-link {
            box-shadow: 0 0 black !important;
        }

        .for-shoting {
            font-weight: 600;
            font-size: 14px;
            padding- {{ Session::get('direction') === 'rtl' ? 'left' : 'right' }}: 9px;
            color: #030303;
        }

        .sidepanel {
            width: 0;
            position: fixed;
            z-index: 6;
            height: 500px;
            top: 0;
            {{ Session::get('direction') === 'rtl' ? 'right' : 'left' }}: 0;
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
            {{ Session::get('direction') === 'rtl' ? 'left' : 'right' }}: 25 px;
            font-size: 36px;
        }

        .openbtn {
            font-size: 18px;
            cursor: pointer;
            background-color: transparent !important;
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
                margin- {{ Session::get('direction') === 'rtl' ? 'left' : 'right' }}: 0% !important;
            }

            .for-mobile {

                margin- {{ Session::get('direction') === 'rtl' ? 'right' : 'left' }}: 10% !important;
            }

        }

        @media (max-width: 500px) {
            .for-mobile {

                margin- {{ Session::get('direction') === 'rtl' ? 'right' : 'left' }}: 27%;
            }

            .openbtn:hover {
                background-color: #fff;
            }

            .for-display {
                display: flex !important;
            }

            .for-tab-display {
                display: none !important;
            }

            .openbtn-tab {
                margin-top: 0 !important;
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
                justify-content: right
            }
        }

        @if (Session::get('direction') === 'rtl')
            .direction_advertis {
                display: flex;
                justify-content: right;
                width: 100%
            }

            .advertis-view-img {
                margin-left: 1rem;
                height: 10rem;
            }

            .advertis-view-body {
                margin-top: 1rem;
            }

            .advertis-view-body>.advertis-view-body-a {
                /* position: absolute; */
                /* bottom: 3rem; */
            }
        @endif

        @if (Session::get('direction') === 'ltr')
            .direction_advertis {
                display: flex;
                justify-content: :left;
                width: 100%
            }

            .advertis-view-img {
                margin-right: 1rem;
                height: 10rem;
            }

            .advertis-view-body {
                margin-top: 1rem;
            }

            .advertis-view-body>.advertis-view-body-a {
                /* position: absolute; */
                /* bottom: 3rem; */
            }
        @endif


        @media (max-width:500px) {
            @if (Session::get('direction') === 'rtl')
                .advertis-view-img {
                    margin-left: 0.5rem;
                    height: 8rem;
                    margin-top: 2px
                }

                .advertis-view-body {
                    margin-top: 0.5rem;
                }

                .advertis-view-body>.advertis-view-body-a {
                    /* position: absolute;
                        bottom: 2rem; */
                }

                .advertis-view-body .advertis-view-body-p {

                    margin: 0;
                    font-size: 15px
                }
            @endif
            @if (Session::get('direction') === 'ltr')
                .advertis-view-img {
                    margin-right: 0.5rem;
                    height: 8rem;
                    margin-top: 2px
                }

                .advertis-view-body {
                    margin-top: 0.5rem;
                }

                .advertis-view-body>.advertis-view-body-a {
                    /* position: absolute;
                        bottom: 2rem; */
                }

                .advertis-view-body .advertis-view-body-p {

                    margin: 0;
                    font-size: 15px
                }

            @endif

        }

        .relative-box {
            position: relative;
            top: 0;

        }

        @if (Session::get('direction') === 'rtl')
            .position-box {
                position: absolute;
                top: 1rem;
                left: 1rem;
            }

            .position-date {
                position: absolute;
                bottom: 1rem;
                left: 1rem;
            }
        @endif
        @if (Session::get('direction') === 'ltr')
            .position-box {
                position: absolute;
                top: 1rem;
                right: 1rem;
            }

            .position-date {
                position: absolute;
                bottom: 1rem;
                right: 1rem;
            }
        @endif
        @media  (max-width: 768px) {
            .testmedia{
                display: flex !important;
                flex-direction: row;
                flex-wrap: wrap;
                align-content: space-around;
            }
            .abd-center{
                text-align: center;
            }
            #testmedia{
                display: none;
            }
            .testmedias{
                display: flex;
                width: 100%;
                flex-direction: column;
                align-items: stretch;
                flex-wrap: wrap;
            }
            .testmedias2{
                display: flex;
                flex-wrap: wrap;
                flex-direction: row;
                justify-content: space-around;
                align-items: center;
            }
        }
    </style>
@endpush

@section('content')
    <div class="container rtl" style="text-align: {{ Session::get('direction') === 'rtl' ? 'right' : 'left' }};">
        <h3 class="headerTitle my-3 text-center" style="text-align: center">
            {{ \App\CPU\translate('Here you can view and manage the ads that you have added') }}</h3>

        @php($decimal_point_settings = \App\CPU\Helpers::get_business_settings('decimal_point_settings'))
        <!-- Page Title-->



        <!-- Page Content-->
        <div class="container pb-5 mb-2 mb-md-4 rtl"
            style="text-align: {{ Session::get('direction') === 'rtl' ? 'right' : 'left' }};">
            <div class="row">
                <!-- Sidebar-->

              
                @include('web-views.partials._profile-aside')

              
                <div id="mySidepanel" class="sidepanel">
                    <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
                    @include('web-views.partials._profile-aside');
                </div>

                <!-- Content  -->
                <section class="col-lg-9">
                    {{-- <div class="col-md-9"> --}}
                    <div class="row mb-3" style="background: rgba(26, 29, 231, 0.068);margin:0px;border-radius:5px;">

                         <div class="col-md-6 m-2 m-md-0 d-flex  align-items-center testmedia">

                        <button class="openbtn text-{{ Session::get('direction') === 'rtl' ? 'right' : 'left' }}"
                            onclick="openNav()">
                            <div>
                                <i class="fa fa-filter"></i>
                                {{ \App\CPU\translate('filter') }}
                            </div>
                        </button>

                        <div class="container pb-4 mb-1 mb-md-3 mt-2">
                            <div class="col-md-15"><br>
                                <form action="{{ route('search-Myjop') }}" method="GET" style="background-color: #ffffff">
                                    @csrf
                                    <div class="input-group mb-8">
                                        <input type="text" class="form-control"
                                            placeholder="{{ \App\CPU\translate('advertisment_name1') }}"
                                            name="name" value="{{ $serch_value }}"  required>
                                        <div class="input-group-append">
                                            <button class="btn btn-outline-primary"
                                                type="submit">{{ \App\CPU\translate('Search') }}</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="col-sm-1 col-md-2">
                            <a href="{{ route('MyAdvertisment') }}"><svg xmlns="http://www.w3.org/2000/svg"
                                    fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"
                                    style="width: 50px">
                                    <path stroke-linecap="round" stroke-linejoin="round"
                                        d="M16.023 9.348h4.992v-.001M2.985 19.644v-4.992m0 0h4.992m-4.993 0l3.181 3.183a8.25 8.25 0 0013.803-3.7M4.031 9.865a8.25 8.25 0 0113.803-3.7l3.181 3.182m0-4.991v4.99" />
                                </svg></a>

                            {{-- <a class="btn btn-primary" href="{{ route('admin.desblayAdvertisement') }}">  {{\App\CPU\translate('Reload data')}}</a> --}}
                            </div>
                        </div>
                        <div class="col-md-6 d-flex  align-items-center">
                            {{-- if need data from also --}}
                            {{-- <h1 class="h3 text-dark mb-0 headerTitle text-uppercase">{{\App\CPU\translate('product_by')}} {{$data['data_from']}} ({{ isset($brand_name) ? $brand_name : $data_from}})</h1> --}}
                            <h1 class="{{ Session::get('direction') === 'rtl' ? 'mr-3' : 'ml-3' }}">

                                {{-- <label id="price-filter-count"> {{$products->total()}} {{\App\CPU\translate('items found')}} </label> --}}
                            </h1>
                        </div>
                       





                    </div>

                    <div class="row">
                        <!-- advertis grid-->
                        @foreach ($Advertis as $shop)
                            <div class="col-lg-12 px-2 pb-4">
                                <div class="card-body shadow relative-box" style="width: 100%">

                                    <div class="direction_advertis testmedias">

                                        @if ($shop->image)
                                            <img style="vertical-align: middle; border-radius: 3%;"
                                                class="advertis-view-img"
                                                onerror="this.src='{{ asset('public/assets/front-end/img/image-place-holder.png') }}'"
                                                src="{{ asset('public/uploads/'.$shop->image[0]) }}"
                                                alt="{{ $shop->name }}">
                                        @else
                                            <img style="vertical-align: middle; border-radius: 3%;"
                                                class="advertis-view-img"
                                                onerror="this.src='{{ asset('public/assets/front-end/img/image-place-holder.png') }}'"
                                                src="" alt="{{ $shop->name }}">
                                        @endif
                                        <div class="advertis-view-body">
                                            <div class="text-dark">
                                                <h1 class="font-weight-bold small">{{ Str::limit($shop->name, 14) }}</h1>
                                                <p class=""> {{ $shop->StateAdvertis->name }} ,
                                                    {{ $shop->CityAdvertis->name }} , {{ $shop->Governorate->name }} </p>
                                                <p class="advertis-view-body-p" style="color: rebeccapurple">
                                                    <button class=" border btn-sm">{{ $shop->CareerSector->name }}</button> <button class="border btn-sm">{{ $shop->JobTitle->name }}</button> <button class="border btn-sm">{{ $shop->experience->experiences_level }}</button> <button class="border btn-sm">{{ $shop->educationDegree->name }}</button>
                                                </p>
                                            </div>
                                            <div class="advertis-view-body-a ">
                                                @if ($shop->status == 'Active')
                                                    <a href="" class="btn btn-success btn-sm"
                                                        style="margin-top:5px;margin-bottom: 10px;padding-top:5px;padding-bottom:5px;padding-left:10px;padding-right:10px;">
                                                        {{ \App\CPU\translate('Been_approved') }}</a>
                                                    <a href="{{ route('desblayAdvertisement', $shop->id) }}"
                                                        class="btn btn-info btn-sm"
                                                        style="margin-top:5px;margin-bottom: 10px;padding-top:5px;padding-bottom:10px;padding-left:10px;padding-right:10px;bottom:40;">{{ \App\CPU\translate('show_advertism_detail') }}</a>
                                                @else
                                                    <a href="" class="btn btn-primary btn-sm"
                                                        style="margin-top:5px;margin-bottom: 10px;padding-top:5px;padding-bottom:5px;padding-left:10px;padding-right:10px;">
                                                        {{ \App\CPU\translate('pending_') }}</a>
                                                    <a href="{{ route('desblayAdvertisement', $shop->id) }}"
                                                        class="btn btn-info btn-sm"
                                                        style="margin-top:5px;margin-bottom: 10px;padding-top:5px;padding-bottom:10px;padding-left:10px;padding-right:10px;bottom:40;">{{ \App\CPU\translate('show_advertism_detail') }}</a>
                                                @endif

                                                <div class="col-md-8" style="top: 10%">
                                                    <div class="advertis-view-body">

                                                    </div>
                                                </div>
                                            </div>

                                        </div>

                                    </div>
                                    <a class="btn btn-danger position-box btn-sm delete" style="cursor: pointer;"
                                        title="{{ \App\CPU\translate('Delete') }}" id="{{ $shop['id'] }}">
                                        <i class="tio-add-to-trash"></i>
                                    </a>
                                    <p class="mb-0 position-date">{{ $shop->created_at->diffForHumans() }}</p>
                                </div>
                            </div>
                        @endforeach

                    </div>







                </section>
            </div>
        </div>
    @endsection

    @push('script')
        <script>
            function openNav() {
                document.getElementById("mySidepanel").style.width = "70%";
                document.getElementById("mySidepanel").style.height = "100vh";
            }

            function closeNav() {
                document.getElementById("mySidepanel").style.width = "0";
            }





            $('#searchByFilterValue, #searchByFilterValue-m').change(function() {
                var url = $(this).val();
                if (url) {
                    window.location = url;
                }
                return false;
            });

            $("#search-brand").on("keyup", function() {
                var value = this.value.toLowerCase().trim();
                $("#lista1 div>li").show().filter(function() {
                    return $(this).text().toLowerCase().trim().indexOf(value) == -1;
                }).hide();
            });
        </script>




        <script>
            $(document).ready(function() {
                $('select[name="career_sector"]').on('change', function() {
                    var CareerSectorId = $(this).val();
                    if (CareerSectorId) {
                        $.ajax({
                            url: "{{ URL::to('admin/selectCareerSector') }}/" + CareerSectorId,
                            type: "GET",
                            dataType: "json",
                            success: function(data) {
                                $('select[name="job_title"]').empty().append(
                                    '<option value="" disabled selected>{{ \App\CPU\translate('name_job_title') }}</option>'
                                    );;
                                $.each(data, function(key, value) {
                                    $('select[name="job_title"]').append('<option value="' +
                                        key + '">' + value + '</option>');
                                });
                            },
                        });
                    } else {
                        console.log('AJAX load did not work');
                    }
                });
            });
        </script>


        <script>
            $(document).ready(function() {
                $('select[name="state_advertis"]').on('change', function() {
                    var StateAdvertisID = $(this).val();
                    if (StateAdvertisID) {
                        $.ajax({
                            url: "{{ URL::to('admin/selectStateAdvertis') }}/" + StateAdvertisID,
                            type: "GET",
                            dataType: "json",
                            success: function(data) {
                                $('select[name="city_advertis"]').empty().append(
                                    '<option value="" disabled selected>{{ \App\CPU\translate('Select the governorate') }}</option>'
                                    );
                                $.each(data, function(key, value) {
                                    $('select[name="city_advertis"]').append(
                                        '<option value="' +
                                        key + '">' + value + '</option>');
                                });
                            },
                        });
                    } else {
                        console.log('AJAX load did not work');
                    }
                });
            });
        </script>
        <script>
            $(document).on('click', '.delete', function() {
                var id = $(this).attr("id");
                Swal.fire({
                    title: '{{ \App\CPU\translate('Are_you_sure') }}?',
                    text: "{{ \App\CPU\translate('Do you want to delete this ad of yours?') }}",
                    showCancelButton: true,
                    type: 'warning',
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: '{{ \App\CPU\translate('Yes') }}, {{ \App\CPU\translate('delete_it') }}!',
                    reverseButtons: true
                }).then((result) => {
                    if (result.value) {
                        $.ajaxSetup({
                            headers: {
                                'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                            }
                        });
                        $.ajax({
                            url: "{{ route('deleteAdvertis') }}",
                            method: 'delete',
                            data: {
                                id: id
                            },
                            success: function() {
                                // toastr.success('{{ \App\CPU\translate('Category_deleted_Successfully.') }}');
                                location.reload();
                            }
                        });
                    }
                })
            });
        </script>
    @endpush
