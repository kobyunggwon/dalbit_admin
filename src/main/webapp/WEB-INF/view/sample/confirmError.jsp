<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrapper">
    <div id="page-wrapper">
        <div id="container-fluid">
            <h3>log - error data 확인</h3>
            <!-- searchBox -->
            <form id="searchForm">
                <div class="row col-lg-12 form-inline">
                    <div class="widget widget-table searchBoxArea">
                        <div class="widget-header searchBoxRow">
                            <h3 class="title"><i class="fa fa-search"></i> 검색조건</h3>
                            <div>
                                <div class="input-group date" id="date_startSel">
                                    <input type="text" class="form-control " id="txt_startSel" name="txt_startSel"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" id="i_startSel"></i></span>
                                </div>
                                <label>~</label>
                                <div class="input-group date" id="date_endSel">
                                    <input type="text" class="form-control" id="txt_endSel" name="txt_endSel"><span class="input-group-addon"><i class="glyphicon glyphicon-calendar" id="i_endSel"></i></span>
                                </div>
                                <span id="osTypeArea"></span>
                                <button type="button" class="btn btn-success" id="bt_search">검색</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <!-- // searchBox -->

            <!-- error log table-->
            <div class="row col-lg-12 form-inline">
                <span>
                    <button class="btn btn-default print-btn" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>
                </span>
                <div class="widget widget-table"  style="width:5000px; overflow: scroll">
                    <div class="widget-content">
                        <table id="errorList" class="table table-sorting table-hover table-bordered datatable">
                            <thead>
                            <th>idx</th>
                            <th>mem_no</th>
                            <th>ostype</th>
                            <th>version</th>
                            <th>build</th>
                            <th>dtype</th>
                            <th>ctype</th>
                            <th>desc</th>
                            <th>upd_date</th>
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/code/sample/sampleCodeList.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        init();
    });

    $('input[id="searchText"]').keydown(function(e) {
        if (e.keyCode === 13) {
            getErrorList();
        };
    });

    $('#bt_search').click( function() {       //검색
        getErrorList();
    });

    function init() {
        $("#osTypeArea").html(util.getCommonCodeSelect(-1, search_osType));

        $('#txt_startSel').datepicker("setDate", new Date());
        $('#txt_endSel').datepicker("setDate", new Date());

        $('#txt_startSel').datepicker().on('dp.change',function(e){
            $(this).html($(this).val());
        });
        $('#txt_endSel').datepicker().on('dp.change',function(e){
            $(this).html($(this).val());
        });

        getErrorList();
    }

    function getErrorList(){
        util.getAjaxData("errorList", "/rest/sample/errorList", $('#searchForm').serialize(), fn_success);
    }

    function fn_success(dst_id, response) {
        dalbitLog(response);
        var template = $('#tmp_errorList').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);

        $("#tableBody").html(html);

    }

    $("#excelDownBtn").on('click', function() {

        var formElement = document.querySelector("form");
        var formData = new FormData(formElement);

        util.excelDownload($(this), "/rest/sample/errorListExcel", formData);
    });

</script>

<script id="tmp_errorList" type="text/x-handlebars-template">
    {{#data}}
    <tr>
        <td>{{idx}}</td>
        <td>{{mem_no}}</td>
        <td>{{ostype}}</td>
        <td>{{version}}</td>
        <td>{{build}}</td>
        <td>{{dtype}}</td>
        <td>{{ctype}}</td>
        <td style="text-align:left">{{desc}}</td>
        <td>{{upd_date}}</td>
    </tr>
    {{/data}}
</script>