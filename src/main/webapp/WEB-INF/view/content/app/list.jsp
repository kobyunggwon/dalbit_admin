<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <form id="searchForm">
                <div class="row col-lg-12 form-inline">
                    <div class="widget widget-table searchBoxArea">
                        <div class="widget-header searchBoxRow">
                            <h3 class="title"><i class="fa fa-search"></i>검색조건</h3>
                            <span id="search_os_area"></span>
                            <button type="button" class="btn btn-success" id="bt_search">검색</button>
                        </div>
                    </div>
                </div>
            </form>
            <div class="row col-lg-12 form-inline" id="insertBtn">
                <button type="button" class="btn btn-default pull-right" id="bt_insert">등록</button>
            </div>
            <div class="row col-lg-12 form-inline">
                <div class="widget widget-table">
                    <div class="widget-header">
                        <h3><i class="fa fa-desktop"></i>검색결과</h3>
                    </div>
                </div>
                <div class="widget-content">
                    <table id="list_info" class="table table-sorting table-hover table-bordered">
                        <thead></thead>
                        <tbody id="tableBody"></tbody>
                    </table>
                </div>
                <%--<div class="widget-footer">--%>
                    <%--<span>--%>
                        <%--<button type="button" class="btn btn-danger" id="bt_delete">선택삭제</button>--%>
                    <%--</span>--%>
                    <%--<span>--%>
                        <%--<button class="btn btn-default print-btn pull-right hide" type="button" id="bt_edit">수정하기</button>--%>
                    <%--</span>--%>
                <%--</div>--%>
            </div> <!-- #DataTable -->
            <form id="appList"></form>
        </div> <!-- #container-fluid -->
    </div><!-- #page-wrapper -->
</div> <!-- #wrapper -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js"></script>
<script type="text/javascript">
    var dtList_info;
    $(document).ready(function () {
        init();
        ui.checkBoxInit('list_info')
    });

    $("#bt_search").click(function () {
        getAppList();
    });

    /** Data Table **/
    function init() {
        var dtList_info_data = function (data) {
        };
        dtList_info = new DalbitDataTable($("#list_info"), dtList_info_data, AppDataTableSource.appInfo, $("#searchForm"));
        dtList_info.useCheckBox(true);
        dtList_info.useIndex(false);
        dtList_info.createDataTable();

        $("#search_os_area").html(util.getCommonCodeSelect(-1, content_selectApp));

        getAppList();
    }

    function getAppList() {
        dtList_info.reload();
        ui.toggleSearchList();
    }

    $(document).on('click', '._appDetail', function () {

        var data = {
            'idx': $(this).data('idx')
        };
        util.getAjaxData("detail", "/rest/content/app/detail", data, fn_detail_success);
        if($("#bt_insert").removeClass("hide")) {
            $("#bt_insert").show();
        }
        if($("#bt_edit").removeClass("hide")) {
            $("#bt_edit").show();
        }

    });

    $(document).on('click', '#list_info .dt-body-center input[type="checkbox"]', function () {
        if ($(this).prop('checked')) {
            $(this).prop('checked', 'checked');
            $(this).parent().parent().find('._appDetail').click();
        } else {
            $("#appList").empty();
            $("#bt_edit").hide();
        }
    });

    var obj = new Object();
    function fn_detail_success(dst_id, response) {
        dalbitLog(response);
        var template = $("#tmp_appList").html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);

        obj = response.data;
        $("#appList").html(html);
        disabled();
    }

    function disabled() {
        if($("#bt_insert").length > 0) {
            $('input:radio[name="os"]').attr("disabled", "disabled");
            $('input:radio[name="is_use"]').attr("disabled", "disabled");
            $('input:radio[name="is_force"]').attr("disabled", "disabled");
            $('input:text[name="version"]').attr("disabled", "disabled");
        }
    }


    $("#bt_insert").on('click', function () {
        $("#appList").empty();
        $(this).hide();
        $("#bt_edit").hide();
        generateForm();
    });

    function generateForm() {
        var template = $('#tmp_appList').html();
        var templateScript = Handlebars.compile(template);
        $("#appList").html(templateScript);
    }

    function isValid() {
        var os = $('input:radio[name="os"]:checked').val();
        if(common.isEmpty(os)) {
            alert("os타입을 선택해주세요.");
            return false;
        }

        var version = $('input:text[name="version"]').val();
        if(common.isEmpty(version)) {
            alert("version을 입력해주세요.");
            return false;
        }

        var isForce = $('input:radio[name="is_force"]:checked').val();
        if(common.isEmpty(isForce)) {
            alert("강제 업데이트 여부를 선택해주세요.");
            return false;
        }

        var isUse = $('input:radio[name="is_use"]:checked').val();
        if(common.isEmpty(isUse)) {
            alert("사용 여부를 선택해주세요.");
            return false;
        }

        return true;
    }

    $(document).on('click', '#insertAppBtn', function () {
        if(isValid()) {
            if (confirm("등록하시겠습니까?")) {
                util.getAjaxData("insert", "/rest/content/app/insert", $("#appList").serialize(), fn_success, fn_fail);
            } else {
                return;
            }
        }
    });

    // // 수정하기
    // $("#bt_edit").on('click', function() {
    //     $(this).hide();
    //     $('input:radio[name="os"]').removeAttr("disabled");
    //     $('input:radio[name="is_use"]').removeAttr("disabled");
    //     $('input:radio[name="is_force"]').removeAttr("disabled");
    //     $('input:text[name="version"]').removeAttr("disabled");
    //
    //     $("#updateAppBtn").removeClass("hide");
    // });

    // $(document).on('click', '#updateAppBtn', function() {
    //     if(isValid()) {
    //         if (confirm("수정하시겠습니까?")) {
    //             util.getAjaxData("update", "/rest/content/app/update", $("#appList").serialize(), fn_success, fn_fail);
    //         } else {
    //             return;
    //         }
    //     }
    // });

    function fn_success(dst_id, response) {
        alert(response.message);
        generateForm();
        dtList_info.reload();
        $('html').animate({scrollTop : 0}, 100);

        $("#appList").empty();
        $("#bt_insert").show();
    }

    function fn_fail() {
        dalbitLog("#####실패");
    }

    // // 삭제하기
    // $("#bt_delete").on('click', function() {
    //     var checked = $('#list_info .dt-body-center input[type="checkbox"]:checked');
    //     if(checked.length == 0) {
    //         alert("삭제할 공지사항을 선택해주세요.");
    //         return
    //     }
    //
    //     if(confirm("삭제하시겠습니까?")) {
    //         var data = {
    //             'idx': obj.idx
    //         };
    //         util.getAjaxData("delete", "/rest/content/app/delete", data, fn_delete_success, fn_fail);
    //     }
    // });
    //
    // function fn_delete_success(dst_id, response) {
    //     alert(response.message);
    //     dtList_info.reload();
    //     $("#appList").empty();
    //     $("#bt_edit").hide();
    // }

</script>

<script id="tmp_appList" type="text/x-handlebars-template">
    <input type="hidden" name="idx" value="{{idx}}"/>
    <div class="row col-lg-12 mt15">
        <div class="col-md-12 no-padding">
            <span>
                {{^idx}}<button class="btn btn-default pull-right mb15" type="button" id="insertAppBtn">등록하기</button>{{/idx}}
                <%--{{#idx}}<button class="btn btn-default pull-right mb15 hide" type="button" id="updateAppBtn">수정완료</button>{{/idx}}--%>
            </span>
        </div>
        <table class="table table-bordered table-dalbit">
            <colgroup>
                <col width="5%"/>
                <col width="10%"/>
            </colgroup>
            <tr>
                <th>os</th>
                <td>
                    {{{getCommonCodeRadio os 'content_radioApp' 'Y' 'os'}}}
                </td>
            </tr>
            <tr>
                <th>version</th>
                <td>
                    <input type="text" name="version" id="version" value="{{version}}" maxlength="10"/>
                </td>
            </tr>
            <tr>
                <th>강제 업데이트 여부</th>
                <td>
                    {{{getCommonCodeRadio is_force 'content_isForce' 'Y' 'is_force'}}}
                </td>
            </tr>
            <tr>
                <th>사용여부</th>
                <td>
                    {{{getCommonCodeRadio is_use 'content_isUse' 'Y' 'is_use'}}}
                </td>
            </tr>
            <tr>
                <th>등록일</th>
                <td>
                    {{convertToDate reg_date "YYYY-MM-DD HH:mm"}}
                </td>
            </tr>
        </table>
    </div>
</script>