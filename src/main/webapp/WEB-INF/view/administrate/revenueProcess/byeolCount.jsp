<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 결제환불 > 총계 -->
<div class="widget widget-table mb10">
    <div class="widget-content mt10" id="divByeolCount">
        <%--<a href="javascript://" class="_prevSearch">[이전]</a>--%>
        <span class="_searchDate"></span>
        <%--<a href="javascript://" class="_nextSearch">[다음]</a>--%>
        <table class="table table-bordered">
            <colgroup>
                <%--<col width="2.7%"/>--%>
            </colgroup>
            <thead>
            <tr>
                <th rowspan="3" class="_bgColor _fontColor" data-bgcolor="#00b050" data-fontcolor="white">조회일자</th>
                <th colspan="14" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">달빛라이브 [별_수량]</th>
            </tr>
            <tr>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">기초</th>
                <th colspan="5" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">증가</th>
                <th colspan="7" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">감소</th>
                <th rowspan="2" class="_bgColor _fontColor" data-bgcolor="#548235" data-fontcolor="white">기말</th>
            </tr>
            <tr>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">합계</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">방송</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">클립</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">이관</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">관리자지급</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">합계</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">환전</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">달로 변환</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">이관</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">회원탈퇴</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">휴면탈퇴</th>
                <th class="_bgColor _fontColor" data-bgcolor="#7b7b7b" data-fontcolor="white">관리자회수</th>
            </tr>
            </thead>
            <tbody id="byeolCountTableBody"></tbody>
        </table>
    </div>
</div>
<a id='byeolCountExcel' type='button' class="btn btn-default print-btn pull-right" download="" href="#" onclick="return ExcellentExport.excel(this, 'divByeolCount', 'Sheet1');"><i class="fa fa-print"></i>Excel Down</a>

<script type="text/javascript">

    function getByeolCountList(){
        $("#byeolCountExcel").attr('download' , "달빛Live_수익인식Process(별금액)_" + moment($("#startDate").val()).add('days', 0).format('YYYY.MM.DD') + ".xls");

        var data = {
            slctType : slctType
            ,startDate : $("#startDate").val()
            ,endDate : $("#endDate").val()
        };
        util.getAjaxData("byeolCount", "/rest/enter/pay/byeol/count", data, fn_byeolCount_success);
    }

    function fn_byeolCount_success(data, response){
        $("#byeolCountTableBody").empty();

        response.data.detailList.slctType = slctType;
        var template = $('#tmp_byeolCountDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#byeolCountTableBody").append(html);

        ui.tableHeightSet();
    }

    function byeolDateClick(data){
        var popupUrl = "/administrate/revenueProcess/popup/byeolAmt?startDate=" + encodeURIComponent(data.thedate);
        util.windowOpen(popupUrl,"1914","968","별 정보 데이터");
    }

</script>

<script type="text/x-handlebars-template" id="tmp_byeolCountDetailList">
    {{#each this as |data|}}
    <tr>
        <td class="font-bold">
            {{#dalbit_if ../slctType '==' 1}}
                <a href="javascript://" onclick="byeolDateClick($(this).data())" data-thedate="{{the_date}}">{{the_date}}</a>
            {{else}}
                {{the_date}}
            {{/dalbit_if}}
        </td>
        <td>{{addComma oldByeol 'Y'}}</td>
        <td>{{addComma addTotal 'Y'}}</td>
        <td>{{addComma addEvent 'Y'}}</td>
        <td>{{addComma addBroad 'Y'}}</td>
        <td>{{addComma addClip 'Y'}}</td>
        <td>{{addComma addMailbox 'Y'}}</td>
        <td>{{addComma addOp 'Y'}}</td>
        <td>{{addComma subTotal 'Y'}}</td>
        <td>{{addComma subExchange 'Y'}}</td>
        <td>{{addComma subChange 'Y'}}</td>
        <td>{{addComma subWithdrawal 'Y'}}</td>
        <td>{{addComma subWithdrawalSleep 'Y'}}</td>
        <td>{{addComma subOp 'Y'}}</td>
        <td>{{addComma newByeol 'Y'}}</td>
        <%--<td>{{addComma errorByeol}}</td>--%>
    </tr>
    {{/each}}
</script>