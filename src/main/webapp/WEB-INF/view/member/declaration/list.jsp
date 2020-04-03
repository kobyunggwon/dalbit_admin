<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-12 no-padding">
    <div class="widget widget-table" id="main_table">
        <span id="declaration_summaryArea"></span>
        <div class="widget-content">
            <table id="list_info_detail" class="table table-sorting table-hover table-bordered datatable">
                <thead id="tableTop_detail">
                </thead>
                <tbody id="tableBody_detail">
                </tbody>
            </table>
        </div>
    </div>
</div>

<form id="declarationForm"></form>

<script>
    $(document).ready(function() {
    });

    function getHistory_declarationDetail(tmp) {     // 상세보기
        if(tmp.indexOf("_") > 0){ tmp = tmp.split("_"); tmp = tmp[1]; }
        console.log("tmp : " + tmp);
        var source = MemberDataTableSource[tmp];

        var dtList_info_detail_data = function (data) {
            data.searchType = 1;
            data.slctType = -1;
            data.slctReason = -1;
            data.searchText = memNo;
        }
        dtList_info_detail = new DalbitDataTable($("#"+tmp).find("#list_info_detail"), dtList_info_detail_data, source);
        dtList_info_detail.useCheckBox(true);
        dtList_info_detail.useIndex(true);
        dtList_info_detail.createDataTable();
        dtList_info_detail.reload();
        initDataTableTop_select_declaration(tmp);    // 상단 selectBox

        util.getAjaxData("summary", "/rest/customer/declaration/opCount", "", fn_success, fn_fail);
    }
    function initDataTableTop_select_declaration(tmp){
        var topTable = '<span name="search_platform_aria_top" id="search_platform_aria_top" onchange="sel_change()"></span>' +
                        '<span name="search_reason_aria_top" id="search_reason_aria_top" onchange="sel_change()"></span>';
        $("#"+tmp).find("#main_table").find(".top-left").addClass("no-padding").append(topTable);
        $("#search_platform_aria_top").html(util.getCommonCodeSelect(-1, search_platform));
        $("#search_reason_aria_top").html(util.getCommonCodeSelect(-1, declaration_reason));
    }

    function sel_change(){
        dtList_info_detail.reload();
    }

    function fn_success(dst_id, response) {
        dalbitLog(response);
        // $( '#declarationSummary > tbody').empty();
        var template = $("#tmp_declarationSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            header : declaration_summary
            , content : response.data
        }
        var html = templateScript(data);
        $("#declaration_summaryArea").html(html);
    }
    function fn_fail(data, textStatus, jqXHR){
        console.log(data, textStatus, jqXHR);
    }

    $(document).on('click', '._getDeclarationDetail', function() {
        var data = {
            'reportIdx' : $(this).data('idx')
        };
        util.getAjaxData("detail", "/rest/customer/declaration/detail", data, fn_detail_success);
    });

    $(document).on('click', '#list_info .dt-body-center input[type="checkbox"]', function() {
        if($(this).prop('checked')){
            $(this).parent().parent().find('._getDeclarationDetail').click();
        }
    });

    var detailData;
    function fn_detail_success(dst_id, response) {
        var template = $('#tmp_declarationFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html=templateScript(context);
        $("#declarationForm").html(html);
        $('#report_title').html("ㆍ신고 시 캡쳐내용은 라이브 방송방 신고시점을 기준으로 5분 이내의 채팅 내역 정보입니다.<br/>ㆍ캡쳐화면 내 닉네임을 클릭하면 클릭한 닉네임의 채팅글만 우측에서 보여집니다.<br/> ㆍ신중히 확인 한 후 조치바랍니다.");
        util.editorInit("customer-declaration");
        detailData = response.data;

        declarationCheck(response.data.status);
    }

</script>

<script id="tmp_declarationSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right">
        <thead>
        <tr>
            {{#each this.header}}
                <th>{{this.code}}</th>
            {{/each}}
        </tr>
        </thead>
        <tbody id="summaryDataTable">
            <td>{{addComma content.notOpCnt}}건</td> <%--미처리--%>
            <td>{{addComma content.allOpCnt}}건</td>
            <td>정상: {{addComma content.code_1_Cnt}}건, 경고: {{addComma content.code_2_Cnt}}건, 강제탈퇴: {{addComma content.telCnt}}건<br/>
                1일: {{addComma content.code_3_Cnt}}건, 3일: {{addComma content.code_4_Cnt}}건, 7일: {{addComma content.code_5_Cnt}}건, 15일: {{addComma content.code_5_Cnt}}건, 30일{{addComma content.code_5_Cnt}}건
            </td> <%--정상--%>
            <td>{{addComma content.code_9_Cnt}}건</td> <%--영구 정지--%>
        </tbody>
    </table>
</script>

<script id="tmp_declarationFrm" type="text/x-handlebars-template">
    <div class="tab-pane fade in active" id="report_tab">
        {{^equal status '1'}}<button type="button" class="btn btn-default print-btn pull-right mt10" id="bt_declaration">처리완료</button>{{/equal}}
        <!-- 상세 -->
        <%--<jsp:include page="../../customer/declaration/report.jsp"/>--%>
    </div>
</script>

