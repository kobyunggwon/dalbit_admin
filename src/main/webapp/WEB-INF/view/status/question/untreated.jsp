<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Date nowTime = new Date();
    SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
%>

<!-- 로그인 현황 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <span class="_searchDate"></span>
        <table class="table table-bordered">
            <colgroup>
                <col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/>
                <col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/><col width="10%"/>
            </colgroup>
            <thead id="totalTable">
            <tr>
                <th>시간대</th>
                <th>소계</th>
                <th>회원정보</th>
                <th>방송하기</th>
                <th>청취하기</th>
                <th>결제</th>
                <th>건의하기</th>
                <th>장애/버그</th>
                <th>선물/아이템</th>
                <th>기타</th>
            </tr>
            </thead>
            <tbody id="untreatedTableBody"></tbody>
            </tbody>
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
        getUntreatedList();
    });

    function getUntreatedList(){
        console.log($("#searchForm").serialize());
        util.getAjaxData("untreated", "/rest/status/question/untreated", $("#searchForm").serialize(), fn_untreated_success);
    }

    function fn_untreated_success(data, response){
        dalbitLog(response);
        var isDataEmpty = response.data.detailList == null;
        $("#untreatedTableBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_untreated').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data.totalInfo;
            var totalHtml = templateScript(context);
            $("#untreatedTableBody").append(totalHtml);
            response.data.detailList.slctType = $('input[name="slctType"]:checked').val();
        }

        var template = $('#tmp_detailList_untreated').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.detailList;
        var html=templateScript(context);
        $("#untreatedTableBody").append(html);

        if(isDataEmpty){
            $("#untreatedTableBody td:last").remove();
        }else{
            $("#untreatedTableBody").append(totalHtml);
        }
    }
</script>
<script type="text/x-handlebars-template" id="tmp_untreated">
    <tr class="success font-bold">
        <td>총계</td>
        <td>{{addComma sum_totalCnt}}</td>
        <td>{{addComma sum_type01Cnt}}</td>
        <td>{{addComma sum_type02Cnt}}</td>
        <td>{{addComma sum_type03Cnt}}</td>
        <td>{{addComma sum_type04Cnt}}</td>
        <td>{{addComma sum_type05Cnt}}</td>
        <td>{{addComma sum_type06Cnt}}</td>
        <td>{{addComma sum_type07Cnt}}</td>
        <td>{{addComma sum_type99Cnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_detailList_untreated">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold">
            {{#equal ../slctType 0}}{{data.daily}}{{/equal}}
            {{#equal ../slctType 1}}{{data.daily}}{{/equal}}
            {{#equal ../slctType 2}}{{data.monthly}}월{{/equal}}
        </td>
        <td>{{addComma totalCnt}}</td>
        <td>{{addComma type01Cnt}}</td>
        <td>{{addComma type02Cnt}}</td>
        <td>{{addComma type03Cnt}}</td>
        <td>{{addComma type04Cnt}}</td>
        <td>{{addComma type05Cnt}}</td>
        <td>{{addComma type06Cnt}}</td>
        <td>{{addComma type07Cnt}}</td>
        <td>{{addComma type99Cnt}}</td>
    </tr>
    {{else}}
    <%--<tr>--%>
    <td colspan="11" class="noData">{{isEmptyData}}<td>
    <%--</tr>--%>
    {{/each}}
</script>