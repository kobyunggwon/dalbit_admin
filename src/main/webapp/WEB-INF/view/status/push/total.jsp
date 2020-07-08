<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 회원가입 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate"></span>
        <table class="table table-bordered _tableHeight" data-height="23px">
            <colgroup>
                <col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/>
                <col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/>
                <col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/><col width="5.8%"/>
                <col width="5.8%"/><col width="5.8%"/>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="2"></th>
                <th colspan="4" class="_sex_male">남성</th>
                <th colspan="4" class="_sex_female">여성</th>
                <th colspan="4" class="_sex_none">알수없음</th>
                <th colspan="4">합계</th>
            </tr>

            <tr>
                <th>발송건수</th>
                <th>성공건수</th>
                <th>실패건수</th>
                <th>성공율</th>
                <th>발송건수</th>
                <th>성공건수</th>
                <th>실패건수</th>
                <th>성공율</th>
                <th>발송건수</th>
                <th>성공건수</th>
                <th>실패건수</th>
                <th>성공율</th>
                <th>발송건수</th>
                <th>성공건수</th>
                <th>실패건수</th>
                <th>성공율</th>
            </tr>
            </thead>
            <tbody id="tableTotalBody"></tbody>
        </table>
    </div>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        getTotal();
    });

    function getTotal(){
        util.getAjaxData("total", "/rest/status/push/total", $("#searchForm").serialize(), fn_total_success);
    }

    function fn_total_success(data, response){
        dalbitLog(response);
        var isDataEmpty = response.data.detailList == null;
        $("#tableTotalBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_total').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#tableTotalBody").append(totalHtml);

            response.data.detailList.slctType = $('input[name="slctType"]:checked').val();
        }

        var template = $('#tmp_totalDetail').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#tableTotalBody").append(html);

        if(isDataEmpty){
            $("#tableTotalBody td:last").remove();
        }

        ui.tableHeightSet();
    }
</script>
<script type="text/x-handlebars-template" id="tmp_total">
    <tr class="font-bold">
        <td>합계</td>
        <td>{{addComma sum_male_send_cnt}}</td>
        <td>{{addComma sum_male_succ_cnt}}</td>
        <td>{{addComma sum_male_fail_cnt}}</td>
        <td>{{average sum_male_succ_cnt sum_male_send_cnt}}%</td>
        <td>{{addComma sum_female_send_cnt}}</td>
        <td>{{addComma sum_female_succ_cnt}}</td>
        <td>{{addComma sum_female_fail_cnt}}</td>
        <td>{{average sum_female_succ_cnt sum_female_send_cnt}}%</td>
        <td>{{addComma sum_none_send_cnt}}</td>
        <td>{{addComma sum_none_succ_cnt}}</td>
        <td>{{addComma sum_none_fail_cnt}}</td>
        <td>{{average sum_none_succ_cnt sum_none_send_cnt}}%</td>
        <td>{{addComma sum_total_send_cnt}}</td>
        <td>{{addComma sum_total_succ_cnt}}</td>
        <td>{{addComma sum_total_fail_cnt}}</td>
        <td>{{average sum_total_succ_cnt sum_total_send_cnt}}%</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_totalDetail">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold">
            {{#equal ../slctType 0}}{{data.hour}}시{{/equal}}
            {{#equal ../slctType 1}}{{data.month}}월 {{data.day}}일{{/equal}}
            {{#equal ../slctType 2}}{{data.year}}년 {{data.month}}월{{/equal}}
        </td>
        <td>{{addComma male_send_cnt}}</td>
        <td>{{addComma male_succ_cnt}}</td>
        <td>{{addComma male_fail_cnt}}</td>
        <td>{{average male_succ_cnt male_send_cnt}}%</td>
        <td>{{addComma female_send_cnt}}</td>
        <td>{{addComma female_succ_cnt}}</td>
        <td>{{addComma female_fail_cnt}}</td>
        <td>{{average female_succ_cnt female_send_cnt}}%</td>
        <td>{{addComma none_send_cnt}}</td>
        <td>{{addComma none_succ_cnt}}</td>
        <td>{{addComma none_fail_cnt}}</td>
        <td>{{average none_succ_cnt none_send_cnt}}%</td>
        <td>{{addComma total_send_cnt}}</td>
        <td>{{addComma total_succ_cnt}}</td>
        <td>{{addComma total_fail_cnt}}</td>
        <td>{{average total_succ_cnt total_send_cnt}}%</td>
    </tr>
    {{else}}
        <td colspan="11" class="noData">{{isEmptyData}}<td>
    {{/each}}
</script>