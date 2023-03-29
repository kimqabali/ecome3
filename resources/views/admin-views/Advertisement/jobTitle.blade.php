@extends('layouts.back-end.app')

@section('title', \App\CPU\translate('Add_job_title'))

@push('css_or_js')
<link href="{{asset('public/assets/back-end')}}/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

@endpush

@section('content')
    <div class="content container-fluid">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="{{route('admin.dashboard')}}">{{\App\CPU\translate('Dashboard')}}</a>
                </li>
                <li class="breadcrumb-item" aria-current="page">{{\App\CPU\translate('Add_job_title')}}</li>
            </ol>
        </nav>

        <!-- Content Row -->
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        {{ \App\CPU\translate('Add_job_title')}}
                    </div>
                    <div class="card-body" style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};">
                        <form action="{{route('admin.AddJobTitle')}}" method="POST">
                            @csrf
                            @php($language=\App\Model\BusinessSetting::where('type','pnc_language')->first())
                            @php($language = $language->value ?? null)
                            @php($default_lang = 'en')
                            @php($default_lang = json_decode($language)[0])
                            <ul class="nav nav-tabs mb-4">
                                @foreach(json_decode($language) as $lang)
                                    <li class="nav-item">
                                        <a class="nav-link lang_link {{$lang == $default_lang? 'active':''}}"
                                           href="#"
                                           id="{{$lang}}-link">{{\App\CPU\Helpers::get_language_name($lang).'('.strtoupper($lang).')'}}</a>
                                    </li>
                                @endforeach
                            </ul>
                            <div class="row">
                                <div class="col-12 col-md-5">
                                    @foreach(json_decode($language) as $lang)
                                        <div class="form-group {{$lang != $default_lang ? 'd-none':''}} lang_form"
                                             id="{{$lang}}-form">
                                            <label class="input-label"
                                                   for="exampleFormControlInput1">{{\App\CPU\translate('name')}}
                                                ({{strtoupper($lang)}})</label>
                                            <input type="text" name="name[]" class="form-control"
                                                   placeholder="{{\App\CPU\translate('enter_job_title')}}">
                                        </div>
                                        <input type="hidden" name="lang[]" value="{{$lang}}">

                                    @endforeach

                                </div>
                                <div class="col-12 col-md-3">
                                    <div class="form-group">
                                        <label for="" > {{\App\CPU\translate('name_carrer_sector')}}</label>
                                        <select name="career_sector_id" class="form-control">
                                            @foreach ($CareerSector as $CareerSectors)
                                                <option value="{{ $CareerSectors->id }}">{{ $CareerSectors->name }}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                </div>



                            </div>

                            <button type="submit" class="btn btn-primary float-right">{{\App\CPU\translate('add')}}</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" style="margin-top: 20px" id="cate-table">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <div class="row flex-between justify-content-between align-items-center flex-grow-1">
                            <div class="col-12 col-sm-6 col-md-6">
                                {{-- <h5>{{ \App\CPU\translate('category_table')}} <span style="color: red;">({{ $categories->total() }})</span></h5> --}}
                            </div>
                            <div class="col-12 col-sm-6 col-md-4" style="width: 30vw">
                                <!-- Search -->
                                 {{-- <form action="{{ url()->current() }}" method="GET">
                                    <div class="input-group input-group-merge input-group-flush">
                                        <div class="input-group-prepend">
                                            <div class="input-group-text">
                                                <i class="tio-search"></i>
                                            </div>
                                        </div> --}}
                                        {{-- <input id="" type="search" name="search" class="form-control" --}}
                                            {{-- placeholder="{{ \App\CPU\translate('search_here')}}" value="{{ $search }}" required> --}}
                                        {{-- <button type="submit" class="btn btn-primary">{{\App\CPU\translate('search')}}</button> --}}
                                    {{-- </div>
                                </form> --}}
                                <!-- End Search -->
                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                    <input id="myInput" type="text"  class="form-control">
                        <div class="table-responsive">
                       
                            <table id="dataTable" class="table table-bordered" style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                                class="table table-borderless table-thead-bordered table-nowrap table-align-middle card-table">
                                <thead class="thead-light">
                                <tr>
                                <th scope="col">{{\App\CPU\translate('SL#')}}</th>
                                    <th style="width: 100px">{{ \App\CPU\translate('category_id')}}</th>
                                    <th>{{ \App\CPU\translate('name')}}</th>
                                    <th> {{\App\CPU\translate('name_carrer_sector')}}</th>
                                    <th  style="width:15%;">{{ \App\CPU\translate('settings')}}</th>

                                </tr>
                                </thead>
                                <tbody>
                                    @foreach ($JobTitle as $count=>$JobTitles)
                                        <tr>
                                        <td style="width: 30px">{{$count+1}}</td>
                                            <td>{{ $JobTitles->id }}</td>
                                            <td>{{ $JobTitles->name }}</td>
                                            <td>{{ $JobTitles->CareerSector->name }}</td>
                                            <td class="d-flex">
                                                <a class="btn btn-primary btn-sm edit" style="cursor: pointer;"
                                                    title="{{ \App\CPU\translate('Edit')}}"
                                                   href="{{route('admin.EditjobTitle',[$JobTitles['id']])}}">
                                                    <i class="tio-edit"></i>
                                                </a>
                                                <span style="width: 10px;"></span>
                                                <a class="btn btn-danger btn-sm delete" style="cursor: pointer;"
                                                    title="{{ \App\CPU\translate('Delete')}}"
                                                   id="{{$JobTitles['id']}}">
                                                    <i class="tio-add-to-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>

                    {{-- <div class="card-footer">
                        {{$categories->links()}}
                    </div> --}}
                    {{-- @if(count($categories)==0)
                        <div class="text-center p-4">
                            <img class="mb-3" src="{{asset('public/assets/back-end')}}/svg/illustrations/sorry.svg" alt="Image Description" style="width: 7rem;">
                            <p class="mb-0">{{\App\CPU\translate('no_data_found')}}</p>
                        </div>
                    @endif --}}
                </div>
            </div>
        </div>
    </div>
@endsection

@push('script')
<script src="{{asset('public/assets/back-end')}}/vendor/datatables/dataTables.bootstrap4.min.js"></script>
<script>
    $(function () {
  $('[data-toggle="tooltip"]').tooltip()
})

        $(".lang_link").click(function (e) {
            e.preventDefault();
            $(".lang_link").removeClass('active');
            $(".lang_form").addClass('d-none');
            $(this).addClass('active');

            let form_id = this.id;
            let lang = form_id.split("-")[0];
            console.log(lang);
            $("#" + lang + "-form").removeClass('d-none');
            if (lang == '{{$default_lang}}') {
                $(".from_part_2").removeClass('d-none');
            } else {
                $(".from_part_2").addClass('d-none');
            }
        });

     

        $(document).on('click', '.delete', function () {
            var id = $(this).attr("id");
            Swal.fire({
                title: '{{\App\CPU\translate('Are_you_sure')}}?',
                text: "{{\App\CPU\translate('You_will_not_be_able_to_revert_this')}}!",
                showCancelButton: true,
                type: 'warning',
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '{{\App\CPU\translate('Yes')}}, {{\App\CPU\translate('delete_it')}}!',
                reverseButtons: true
            }).then((result) => {
                if (result.value) {
                    $.ajaxSetup({
                        headers: {
                            'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                        }
                    });
                    $.ajax({
                        url: "{{route('admin.deletejobTitle')}}",
                        method: 'delete',
                        data: {id: id},
                        success: function () {
                            // toastr.success('{{\App\CPU\translate('Category_deleted_Successfully.')}}');
                            location.reload();
                        }
                    });
                }
            })
        });

    // Call the dataTables jQuery plugin
    $(document).ready(function () {
        $('#dataTable').DataTable({
            "pageLength": {{\App\CPU\Helpers::pagination_limit()}}
           
        });
        var table = $('#dataTable').DataTable();
 
// #myInput is a <input type="text"> element
    $('#myInput').on( 'keyup', function () {
        consile.log('ff');
        table.search( this.value ).draw();
    } );
    });

 </script>
@endpush
