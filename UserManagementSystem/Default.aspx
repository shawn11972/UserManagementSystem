<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UserManagementSystem._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link href="https://cdn.datatables.net/v/bs5/jq-3.7.0/jszip-3.10.1/dt-2.0.0/b-3.0.0/b-html5-3.0.0/cr-2.0.0/datatables.min.css" rel="stylesheet">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/v/bs5/jq-3.7.0/jszip-3.10.1/dt-2.0.0/b-3.0.0/b-html5-3.0.0/cr-2.0.0/datatables.min.js"></script>

    <script type="text/javascript">     

        $(document).ready(function () {
            $('#example thead tr')
                .clone(true)
                .addClass('filters')
                .appendTo('#example thead');
            /*
             * Load the data on page load using AJAX call from Datatable plugin
             *   dom:
             *   B - Buttons
             *   l - Length changing
             *   f - Filtering input
             *   t - The Table!
             *   i - Information
             *   p - Pagination
             */
            var table = $('#example').DataTable({
                orderCellsTop: true,
                fixedHeader: true,
                initComplete: function () {
                    var api = this.api();

                    // For each column
                    api
                        .columns()
                        .eq(0)
                        .each(function (colIdx) {
                            // Set the header cell to contain the input element
                            var cell = $('.filters th').eq(
                                $(api.column(colIdx).header()).index()
                            );
                            var title = $(cell).text();
                            $(cell).html('<input type="text" placeholder="' + title + '" />');

                            // On every keypress in this input
                            $(
                                'input',
                                $('.filters th').eq($(api.column(colIdx).header()).index())
                            )
                                .off('keyup change')
                                .on('change', function (e) {
                                    // Get the search value
                                    $(this).attr('title', $(this).val());
                                    var regexr = '({search})'; //$(this).parents('th').find('select').val();

                                    var cursorPosition = this.selectionStart;
                                    // Search the column for that value
                                    api
                                        .column(colIdx)
                                        .search(
                                            this.value != ''
                                                ? regexr.replace('{search}', '(((' + this.value + ')))')
                                                : '',
                                            this.value != '',
                                            this.value == ''
                                        )
                                        .draw();
                                })
                                .on('keyup', function (e) {
                                    e.stopPropagation();

                                    $(this).trigger('change');
                                    $(this)
                                        .focus()[0]
                                        .setSelectionRange(cursorPosition, cursorPosition);
                                });
                        });
                },
                dom: "<'row'<'col-sm-6'B>>" +
                    "<'row'<'col-sm-6'l><'col-sm-6'f>>" +
                    "<'row'<'col-sm-12'tr>>" +
                    "<'row'<'col-sm-6'i><'col-sm-6'p>>",
                ajax: {

                    url: "Default.aspx/LoadData",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    dataSrc: function (json) {
                        return JSON.parse(json.d);
                    }
                },
                deferRender: true,
                columns: [
                    { 'data': 'Name' },
                    { 'data': 'Email' },
                    { 'data': 'Phone Number' },
                    { 'data': 'Salary' }
                ],
                buttons: [
                    'copy', 'csv',
                    {
                        extend: 'excel',
                        text: 'MS Excel',
                        exportOptions: {
                            columns: [0, 1, 2, 3]
                        }
                    },
                    {
                        extend: 'pdf',
                        text: 'Create PDF',
                        exportOptions: {
                            columns: [0, 1, 2, 3]
                        }
                    }
                ]




            });



        });//End of $(document).ready

    </script>


    <main>
        <div class="row" style="margin-top: 40px;">
            <div class="col-lg-12">
                <asp:GridView runat="server" ID="example" CssClass="table table-striped" AutoGenerateColumns="true" ClientIDMode="Static">
                </asp:GridView>
            </div>
        </div>
    </main>

</asp:Content>
