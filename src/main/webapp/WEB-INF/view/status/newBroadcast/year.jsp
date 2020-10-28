<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 방송현황 > 시간대별 -->
<span class="_searchDate font-bold"></span>
<span class="" style="font-size: 11px;color: red;">
    * 총 수치(비중복 수치)로 표기된 현황입니다.<br/>
    * 게스트 수치는 청취자 수치에 포함됩니다.
</span>
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <div class="col-md-12 no-padding">
            <span class="font-bold">◈DJ/청취자 성별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="3" class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th colspan="5" class="_bgColor" data-bgColor="#b4c7e7">DJ (방송개설)</th>
                    <th rowspan="3" class="_bgColor" data-bgColor="#b4c7e7">방송시간</th>
                    <th colspan="6" class="_bgColor" data-bgColor="#f8cbad">청취자</th>
                    <th rowspan="3" class="_bgColor" data-bgColor="#b4c7e7">선물 수</th>
                    <th rowspan="3" class="_bgColor" data-bgColor="#b4c7e7">선물 달</th>
                </tr>
                <tr>
                    <th colspan="3" class="_bgColor" data-bgcolor="#dae3f3">DJ 성별</th>
                    <th rowspan="2" class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
                    <th rowspan="2" class="_bgColor" data-bgcolor="#dae3f3">최대 개설</th>
                    <th colspan="3" class="_bgColor" data-bgcolor="#fbe5d6">청취자 성별</th>
                    <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">게스트</th>
                    <th rowspan="2" class="_bgColor" data-bgcolor="#d9d9d9">소계</th>
                    <th rowspan="2" class="_bgColor" data-bgcolor="#fbe5d6">최대 청취자</th>
                </tr>
                <tr>
                    <th class="_bgColor _sex_male" data-bgColor="#b4c7e7"></th>
                    <th class="_bgColor _sex_female" data-bgColor="#b4c7e7"></th>
                    <th class="_bgColor _sex_none" data-bgColor="#b4c7e7"></th>
                    <th class="_bgColor _sex_male" data-bgColor="#f8cbad"></th>
                    <th class="_bgColor _sex_female" data-bgColor="#f8cbad"></th>
                    <th class="_bgColor _sex_none" data-bgColor="#f8cbad"></th>
                </tr>
                </thead>
                <tbody id="yearTableBody"></tbody>
            </table>
        </div>

        <div class="col-md-8 no-padding">
            <span class="font-bold">◈선물 별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col width="7.2%"/><col width="14.2%"/><col width="14.2%"/><col width="14.2%"/><col width="14.2%"/>
                    <col width="14.2%"/><col width="14.2%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#b4c7e7">DJ<br/>일반(비밀)</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#f8cbad">게스트<br/>일반(비밀</th>
                    <th colspan="2" class="_bgColor _fontColor" data-bgColor="#000000" data-fontcolor="#ffc000" id="giftTotalCnt">
                        총 합<br/>
                        <span>(일반 + 비밀) 총 건수 / 달 수</span>
                    </th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgColor="#dae3f3">건 수</th>
                    <th class="_bgColor" data-bgColor="#dae3f3">달 수</th>
                    <th class="_bgColor" data-bgColor="#fbe5d6">건 수</th>
                    <th class="_bgColor" data-bgColor="#fbe5d6">달 수</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">건 수</th>
                    <th class="_bgColor" data-bgColor="#f2f2f2">달 수</th>
                </tr>
                </thead>
                <tbody  id="giftYearListBody">
                </tbody>
            </table>
        </div>

        <div class="col-md-8 no-padding">
            <span class="font-bold">◈플랫폼 별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col width="7.1%"/><col width="11.1%"/><col width="11.1%"/><col width="11.1%"/><col width="11.1%"/>
                    <col width="11.1%"/><col width="11.1%"/><col width="11.1%"/><col width="11.1%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th colspan="3" class="_bgColor" data-bgColor="#b4c7e7">방송개설</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#d0cece">소계</th>
                    <th colspan="3" class="_bgColor" data-bgColor="#b4c7e7">방송시간</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#d0cece">소계</th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgColor="#e9ebf5">PC웹</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">안드로이드</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">아이폰</th>

                    <th class="_bgColor" data-bgColor="#e9ebf5">PC웹</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">안드로이드</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">아이폰</th>
                </tr>
                </thead>
                <tbody id="platformYearListBody">
                </tbody>
            </table>
        </div>
        <div class="col-md-8 no-padding">
            <span class="font-bold">◈방송 주제 별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col width="7%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
                    <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
                    <col width="8.3%"/><col width="8.3%"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">수다/챗</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">일상/소통</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">힐링</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">노래/연주</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">미팅/소개팅</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">고민/사연</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">책/여행</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">ASMR</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">성우</th>
                    <th class="_bgColor" data-bgColor="#d0cece">소계</th>
                </tr>
                </thead>
                <tbody id="typeYearTableBody"></tbody>
            </table>
        </div>
    </div>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>

<script type="text/javascript">
    $(function(){
        // getYearList();
    });
    function getYearList(){

        $("._searchDate").html(moment($("#startDate").val()).format('YYYY년'));

        var data = dataSet();
        data.slctType = 2;
        util.getAjaxData("time", "/rest/status/newBroadcast/info/time", data, fn_year_success);

        util.getAjaxData("broadcastGift", "/rest/status/broadcast/broadcastGift/list", data, fn_broadcastgiftYear_success);

        util.getAjaxData("memberList", "/rest/status/broadcast/info/platform", data, fn_platformYearList_success);

        util.getAjaxData("type", "/rest/status/newBroadcast/info/type", data, fn_typeYear_success);
    }

    function fn_year_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        var tableBody = $("#yearTableBody");

        tableBody.empty();
        if(!isDataEmpty){
            var template = $('#tmp_yearTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            tableBody.append(totalHtml);
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD"),2,"0"));
            response.data.detailList[i].nowHour = Number(moment().format("HH"));
            response.data.detailList[i].month = response.data.detailList[i].the_date.substr(5,6);
        }

        var template = $('#tmp_yearDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        tableBody.append(html);

        if(isDataEmpty){
            $("#yearTableBody td:last").remove();
        }else{
            tableBody.append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    function fn_broadcastgiftYear_success(dst_id, response) {
        dalbitLog(response);
        var isDataEmpty = response.data.detailList == null;
        $("#giftYearListBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_giftYear').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#giftYearListBody").append(totalHtml);

            response.data.detailList.slctType = $('input:radio[name="slctType"]:checked').val();
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].month = response.data.detailList[i].monthly;
            response.data.detailList[i].the_date = Number(moment().format("YYYY")) + "-" + common.lpad(response.data.detailList[i].monthly,2,"0");
        }

        var template = $('#tmp_giftYearDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#giftYearListBody").append(html);

        if(isDataEmpty){
            $("#giftYearListBody td:last").remove();
        }else{
            $("#giftYearListBody").append(totalHtml);
        }
        ui.tableHeightSet();
        ui.paintColor();
    }

    function fn_platformYearList_success(dst_id, response) {
        dalbitLog(response);
        var isDataEmpty = response.data.detailList == null;
        $("#platformYearListBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_platformYear').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#platformYearListBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD"),2,"0"));
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].month = response.data.detailList[i].monthly.substr(5,2);
            response.data.detailList[i].the_date = Number(moment().format("YYYY")) + "-" + response.data.detailList[i].monthly.substr(5,2);
        }

        var template = $('#tmp_platformYearDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#platformYearListBody").append(html);

        if(isDataEmpty){
            $("#platformYearListBody td:last").remove();
        }else{
            $("#platformYearListBody").append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    function fn_typeYear_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        var tableBody = $("#typeYearTableBody");

        tableBody.empty();
        if(!isDataEmpty){
            var template = $('#tmp_typeYear').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            tableBody.append(totalHtml);
        }


        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = moment().format("MM");
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].month = response.data.detailList[i].monthly.substr(5,2);
            response.data.detailList[i].the_date = Number(moment().format("YYYY")) + "-" + response.data.detailList[i].monthly.substr(5,2);
        }

        var template = $('#tmp_typeYearDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        tableBody.append(html);

        if(isDataEmpty){
            $("#typeYearTableBody td:last").remove();
        }else{
            tableBody.append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

</script>

<script type="text/x-handlebars-template" id="tmp_yearTotal">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td class="_fontColor" data-fontColor="blue">{{addComma total_create_mCnt}} ({{addComma total_unique_dj_mCnt}})</td>
        <td class="_fontColor" data-fontColor="red">{{addComma total_create_fCnt}} ({{addComma total_unique_dj_fCnt}})</td>
        <td>{{addComma total_create_nCnt}} ({{addComma total_unique_dj_nCnt}})</td>
        <td>{{addComma total_create_totalCnt}} ({{addComma total_unique_dj_Cnt}})</td>
        <td>{{addComma total_create_max_Cnt}}</td>
        <td style="text-align: right">{{timeStampDay total_airtime}}</td>
        <td class="_fontColor" data-fontColor="blue">{{addComma total_listener_mCnt}} ({{addComma total_unique_listener_mCnt}})</td>
        <td class="_fontColor" data-fontColor="red">{{addComma total_listener_fCnt}} ({{addComma total_unique_listener_fCnt}})</td>
        <td>{{addComma total_listener_nCnt}} ({{addComma total_unique_listener_nCnt}})</td>
        <td>{{addComma total_guest_totalCnt}} ({{addComma total_guest_UniqueCnt}})</td>
        <td>{{addComma total_listener_totalCnt}} ({{addComma total_unique_listener_Cnt}})</td>
        <td>{{addComma total_listener_max_Cnt}}</td>
        <td>{{addComma total_gift_Cnt}}</td>
        <td>{{addComma total_gift_Amt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_yearDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowMonth '!=' month}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{data.the_date}}
        </td>
        <td class="_fontColor" data-fontColor="blue">{{#dalbit_if create_mCnt '!=' 0}}{{addComma create_mCnt 'Y'}} ({{addComma unique_dj_mCnt}}){{/dalbit_if}}</td>
        <td class="_fontColor" data-fontColor="red">{{#dalbit_if create_fCnt '!=' 0}}{{addComma create_fCnt 'Y'}} ({{addComma unique_dj_fCnt}}){{/dalbit_if}}</td>
        <td>{{#dalbit_if create_nCnt '!=' 0}}{{addComma create_nCnt 'Y'}} ({{addComma unique_dj_nCnt}}){{/dalbit_if}}</td>
        <td {{#dalbit_if nowHour '!=' the_hr}} class="_bgColor" data-bgColor="#d0cece" {{/dalbit_if}}>{{#dalbit_if create_Cnt '!=' 0}}{{addComma create_Cnt 'Y'}} ({{addComma unique_dj_Cnt}}){{/dalbit_if}}</td>
        <td>{{addComma create_max_Cnt 'Y'}}</td>
        <td style="text-align: right">{{timeStampDay airtime}}</td>
        <td class="_fontColor" data-fontColor="blue">{{#dalbit_if listener_mCnt '!=' 0}}{{addComma listener_mCnt 'Y'}} ({{addComma unique_listener_mCnt}}){{/dalbit_if}}</td>
        <td class="_fontColor" data-fontColor="red">{{#dalbit_if listener_fCnt '!=' 0}}{{addComma listener_fCnt 'Y'}} ({{addComma unique_listener_fCnt}}){{/dalbit_if}}</td>
        <td>{{#dalbit_if listener_nCnt '!=' 0}}{{addComma listener_nCnt 'Y'}} ({{addComma unique_listener_nCnt}}){{/dalbit_if}}</td>
        <td>{{#dalbit_if guest_Cnt '!=' 0}}{{addComma guest_Cnt 'Y'}} ({{addComma guest_unique_Cnt}}){{/dalbit_if}}</td>
        <td {{#dalbit_if nowHour '!=' the_hr}} class="_bgColor" data-bgColor="#d0cece" {{/dalbit_if}}>{{#dalbit_if listener_Cnt '!=' 0}}{{addComma listener_Cnt 'Y'}} ({{addComma unique_listener_Cnt}}){{/dalbit_if}}</td>
        <td>{{addComma listener_max_Cnt 'Y'}}</td>
        <td>{{addComma gift_Cnt 'Y'}}</td>
        <td>{{addComma gift_Amt 'Y'}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="20" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>

<script type="text/x-handlebars-template" id="tmp_giftYear">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td>{{addComma sum_normalGiftCnt}} ({{addComma sum_secretGiftCnt}})</td>
        <td>{{addComma sum_normalGiftAmount}} ({{addComma sum_secretGiftAmount}})</td>
        <td>{{addComma sum_guest_normalGiftCnt}} ({{addComma sum_guest_secretGiftCnt}})</td>
        <td>{{addComma sum_guest_normalGiftAmount}} ({{addComma sum_guest_secretGiftAmount}})</td>
        <td>{{addComma sum_totalGiftCnt}} ({{addComma sum_totalSecretGiftCnt}})</td>
        <td>{{addComma sum_totalGiftAmount}} ({{addComma sum_totalSecretGiftAmount}})</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_giftYearDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowMonth '!=' month}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{{the_date}}}
        </td>
        <td>{{addComma normalGiftCnt}} ({{addComma secretGiftCnt}})</td>
        <td>{{addComma normalGiftAmount}} ({{addComma secretGiftAmount}})</td>
        <td>{{addComma guest_normalGiftCnt}} ({{addComma guest_secretGiftCnt}})</td>
        <td>{{addComma guest_normalGiftAmount}} ({{addComma guest_secretGiftAmount}})</td>
        <td>{{addComma totalGiftCnt}} ({{addComma totalSecretGiftCnt}})</td>
        <td>{{addComma totalGiftAmount}} ({{addComma totalSecretGiftAmount}})</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="22" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>

<script type="text/x-handlebars-template" id="tmp_platformYear">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td>{{addComma sum_pcCnt}}</td>
        <td>{{addComma sum_androidCnt}}</td>
        <td>{{addComma sum_iosCnt}}</td>
        <td>{{addComma sum_totalCreateCnt}} ({{addComma sum_unique_dj_Cnt}})</td>
        <td style="text-align: right">{{timeStampDay sum_pcTime}}</td>
        <td style="text-align: right">{{timeStampDay sum_androidTime}}</td>
        <td style="text-align: right">{{timeStampDay sum_iosTime}}</td>
        <td style="text-align: right">{{timeStampDay sum_totalBroadcastingTime}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_platformYearDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowMonth '!=' month}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{{the_date}}}
        </td>
        <td>{{addComma pcCnt 'Y'}}</td>
        <td>{{addComma androidCnt 'Y'}}</td>
        <td>{{addComma iosCnt 'Y'}}</td>
        <td {{#dalbit_if nowMonth '!=' month}} class="_bgColor" data-bgColor="#d0cece" {{/dalbit_if}}>{{#dalbit_if totalCreateCnt '!=' 0}}{{addComma totalCreateCnt}} ({{addComma unique_dj_Cnt}}){{/dalbit_if}}</td>
        <td style="text-align: right">{{timeStampDay pcTime}}</td>
        <td style="text-align: right">{{timeStampDay androidTime}}</td>
        <td style="text-align: right">{{timeStampDay iosTime}}</td>
        <td style="text-align: right" {{#dalbit_if nowMonth '!=' month}} class="_bgColor" data-bgColor="#d0cece" {{/dalbit_if}}>{{timeStampDay totalBroadcastingTime}}</td>
    </tr>
    {{/each}}
</script>


<script type="text/x-handlebars-template" id="tmp_typeYear">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td>{{addComma sum_create03Cnt}}</td>
        <td>{{addComma sum_create00Cnt}}</td>
        <td>{{addComma sum_create01Cnt}}</td>
        <td>{{addComma sum_create02Cnt}}</td>
        <td>{{addComma sum_create04Cnt}}</td>
        <td>{{addComma sum_create05Cnt}}</td>
        <td>{{addComma sum_create06Cnt}}</td>
        <td>{{addComma sum_create09Cnt}}</td>
        <td>{{addComma sum_create13Cnt}}</td>
        <td>{{addComma sum_totalCreateCnt}} ({{addComma sum_unique_dj_Cnt}})</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_typeYearDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowMonth '==' month}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowMonth '!=' month}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{{the_date}}}
        </td>
        <td>{{addComma create03Cnt 'Y'}}</td>
        <td>{{addComma create00Cnt 'Y'}}</td>
        <td>{{addComma create01Cnt 'Y'}}</td>
        <td>{{addComma create02Cnt 'Y'}}</td>
        <td>{{addComma create04Cnt 'Y'}}</td>
        <td>{{addComma create05Cnt 'Y'}}</td>
        <td>{{addComma create06Cnt 'Y'}}</td>
        <td>{{addComma create09Cnt 'Y'}}</td>
        <td>{{addComma create13Cnt 'Y'}}</td>
        <td {{#dalbit_if nowMonth '!=' month}} class="_bgColor" data-bgColor="#d0cece" {{/dalbit_if}}>{{#dalbit_if totalCreateCnt '!=' 0}}{{addComma totalCreateCnt 'Y'}} ({{addComma unique_dj_Cnt}}){{/dalbit_if}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="11" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>