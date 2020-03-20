<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-12 no-padding">
    <div class="widget widget-table" id="main_table">
        <div class="widget-content">
            <table id="list_info_detail" class="table table-sorting table-hover table-bordered datatable">
                <thead id="tableTop_detail"></thead>
                <tbody id="tableBody_detail"></tbody>
            </table>
        </div>
    </div>
</div>
<div class="col-md-12 no-padding hide" id="question_tab">
    <jsp:include page="questionTab.jsp"></jsp:include>
</div>
<script>
    $(document).ready(function() {
    });

    function getHistory_questionDetail(tmp) {     // 상세보기
        if(tmp.indexOf("_") > 0){ tmp = tmp.split("_"); tmp = tmp[1]; }
        var source = MemberDataTableSource[tmp];
        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
        }
        dtList_info_detail = new DalbitDataTable($("#"+tmp).find("#list_info_detail"), dtList_info_detail_data, source);
        dtList_info_detail.useCheckBox(false);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.createDataTable();
        dtList_info_detail.reload();

        initDataTableTop(tmp);                      // 상단 정보 테이블
        initDataTableTop_select_quest(tmp);         // 상탄 selectBox
    }
    function initDataTableTop(tmp){
        var topTable = '<div class="col-md-12 no-padding pull-right">\n' +
            '                <div class="widget-table" id="main_table_top">\n' +
            '                    <div class="widget-content no-padding">\n' +
            '                        <table id="top_info" class="table table-sorting table-hover table-bordered">\n' +
            '                            <thead id="table_Top"></thead>\n' +
            '                            <tbody id="table_Body"></tbody>\n' +
            '                        </table>\n' +
            '                    </div>\n' +
            '                </div>\n' +
            '            </div>';

        $("#"+tmp).find("#main_table").find(".top-right").addClass("no-padding").append(topTable);

        var top = tmp.replace("Detail","_top");
        var source = MemberDataTableSource[top];
        var dtList_info_detail_data = function (data) {
            data.mem_no = memNo;
        }
        dtList_top_info = new DalbitDataTable($("#"+tmp).find("#top_info"), dtList_info_detail_data, source);
        dtList_top_info.useCheckBox(false);
        dtList_top_info.useIndex(false);
        dtList_top_info.useOrdering(false);
        dtList_top_info.onlyTableView();
        dtList_top_info.createDataTable();
        dtList_top_info.reload();
    }

    function initDataTableTop_select_quest(tmp){
        var topTable = '<span name="search_question_top" id="search_question_top" onchange="sel_change()"></span>' +
            '<span name="search_question_type_top" id="search_question_type_top" onchange="sel_change()"></span>' +
            '<span name="search_platform_top" id="search_platform_top" onchange="sel_change()"></span>' +
            '<span name="search_browser_top" id="search_browser_top" onchange="sel_change()"></span>'
        ;
        $("#"+tmp).find("#main_table").find(".top-left").addClass("no-padding").append(topTable);
        $("#search_question_top").html(util.getCommonCodeSelect(-1, question));
        $("#search_question_type_top").html(util.getCommonCodeSelect(-1, question_type));
        $("#search_platform_top").html(util.getCommonCodeSelect(-1, platform));
        $("#search_browser_top").html(util.getCommonCodeSelect(-1, browser));

    }
    // function sel_change(value){
    //     console.log("value : " + value);
    // }
    function Question(index){

        $('#question_tab').addClass("show");
        var data = dtList_info_detail.getDataRow(index);
        var roomNo = data.roomNo;
        console.log('Question~ roomNo : ' + roomNo);
    }

    $('#one_title').html("ㆍ회원의 1:1문의 내용을 확인하고, 답변 및 처리할 수 있습니다. 신중히 확인 한 후 답변바랍니다.");
    $('#call_title').html("ㆍ전화문의 시 정보를 등록하고 처리 한 정보입니다.<br>ㆍ전화문의 시 회원이 문의 한 내용을 최대한 자세히 작성해 주세요.");
    $('#mail_title').html("ㆍ회원의 메일 문의 내용을 확인하고, 답변 및 처리할 수 있습니다. 신중히 확인 한 후 답변바랍니다.");

</script>
