@extends('layouts.back-end.app')

@section('title', \App\CPU\translate('carrer_sector'))

@push('css_or_js')

<link href="{{asset('public/assets/back-end')}}/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

@endpush

@section('content')
    <div class="content container-fluid">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="{{route('admin.dashboard')}}">{{\App\CPU\translate('Dashboard')}}</a>
                </li>
                <li class="breadcrumb-item" aria-current="page">{{\App\CPU\translate('carrer_sector')}}</li>
            </ol>
        </nav>

        <!-- Content Row -->
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        {{ \App\CPU\translate('carrer_sector')}}
                    </div>
                    <div class="card-body" style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};">
                        <form action="{{route('admin.AddCareerSector')}}" method="POST">
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
                                                   placeholder="{{\App\CPU\translate('New_category')}}" {{$lang == $default_lang? 'required':''}}>
                                        </div>
                                        <input type="hidden" name="lang[]" value="{{$lang}}">
                                    @endforeach

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
                   
                    <div class="card-body">
                        <div class="table-responsive">
                            <table id="dataTable" class="table table-bordered" style="text-align: {{Session::get('direction') === "rtl" ? 'right' : 'left'}};"
                                class="table table-borderless table-thead-bordered table-nowrap table-align-middle card-table">
                                <thead class="thead-light">
                                <tr>
                                    <th>{{ \App\CPU\translate('category_id')}}</th>
                                    <th>{{ \App\CPU\translate('name')}}</th>
                                    <th  style="width:15%;" colspan="2">{{ \App\CPU\translate('settings')}}</th>

                                </tr>
                                </thead>
                                <tbody>
                                    @foreach ($CareerSector as $CareerSectors)
                                        <tr>
                                            <td>{{ $CareerSectors->id }}</td>
                                            <td>{{ $CareerSectors->name }}</td>
                                            <td class="d-flex">
                                                <a class="btn btn-primary btn-sm edit" style="cursor: pointer;"
                                                    title="{{ \App\CPU\translate('Edit')}}"
                                                   href="{{route('admin.EditCareerSector',[$CareerSectors['id']])}}">
                                                    <i class="tio-edit"></i>
                                                </a>
                                                <a class="btn btn-danger btn-sm delete" style="cursor: pointer;"
                                                    title="{{ \App\CPU\translate('Delete')}}"
                                                   id="{{$CareerSectors['id']}}">
                                                    <i class="tio-add-to-trash"></i>
                                                </a>
                                            </td>
                                        </tr>
                                    @endforeach

                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
@endsection

@push('script')
<script>
    $(function () {
  $('[data-toggle="tooltip"]').tooltip()
})
</script>
    <script>
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

        $(document).ready(function () {
            $('#dataTable').DataTable();
        });
    </script>

    {{-- <script>
        $(document).on('change', '.category-status', function () {
            var id = $(this).attr("id");
            if ($(this).prop("checked") == true) {
                var status = 1;
            } else if ($(this).prop("checked") == false) {
                var status = 0;
            }
            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': $('meta[name="_token"]').attr('content')
                }
            });
            $.ajax({
                url: "{{route('admin.category.status')}}",
                method: 'POST',
                data: {
                    id: id,
                    home_status: status
                },
                success: function (data) {
                    if(data.success == true) {
                        toastr.success('{{\App\CPU\translate('Status updated successfully')}}');
                    }
                }
            });
        });
    </script> --}}
    <script>
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
                        url: "{{route('admin.deleteCareerSector')}}",
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
    </script>

 


    <!-- Page level plugins -->
<script src="{{asset('public/assets/back-end')}}/vendor/datatables/dataTables.bootstrap4.min.js"></script>
<!-- Page level custom scripts -->
<script>
    // Call the dataTables jQuery plugin
    $(document).ready(function () {
        $('#dataTable').DataTable({
            "pageLength": {{\App\CPU\Helpers::pagination_limit()}}
        });
    });

 </script>
@endpush
