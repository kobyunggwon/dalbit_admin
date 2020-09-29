<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 방송현황 > 시간대별 -->
<span class="_searchDate font-bold"></span>
<div class="widget widget-table mb10">
    <div class="widget-content mt10">
        <div class="col-md-10 no-padding">
            <span class="font-bold">◈클립등록자 성별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col width="4.9%"/>
                    <col width="4.5%"/><col width="4.7%"/><col width="4.7%"/><col width="4.7%"/><col width="4.7%"/>
                    <col width="4.5%"/><col width="4.7%"/><col width="4.7%"/><col width="4.7%"/><col width="4.7%"/>
                    <col width="4.5%"/><col width="4.7%"/><col width="4.7%"/><col width="4.7%"/><col width="4.7%"/>
                    <col width="4.5%"/><col width="4.7%"/><col width="4.7%"/><col width="4.7%"/><col width="4.7%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="3" class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th colspan="5" class="_bgColor _sex_male" data-bgColor="#b4c7e7"></th>
                    <th colspan="5" class="_bgColor _sex_female" data-bgColor="#b4c7e7"></th>
                    <th colspan="5" class="_bgColor _sex_none" data-bgColor="#b4c7e7"></th>
                    <th colspan="5" class="_bgColor" data-bgColor="#d0cece">총합계</th>
                </tr>
                <tr>
                    <th rowspan="2" class="_bgColor" data-bgColor="#e9ebf5">등록자</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#e9ebf5">등록</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#e9ebf5">삭제</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#e9ebf5">등록자</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#e9ebf5">등록</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#e9ebf5">삭제</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#e9ebf5">등록자</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#e9ebf5">등록</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#e9ebf5">삭제</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#d0cece">등록자</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#d0cece">등록</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#d0cece">삭제</th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgColor="#e9ebf5">공개</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">비공개</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">본인</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">운영자</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">공개</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">비공개</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">본인</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">운영자</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">공개</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">비공개</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">본인</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">운영자</th>
                    <th class="_bgColor" data-bgColor="#d0cece">공개</th>
                    <th class="_bgColor" data-bgColor="#d0cece">비공개</th>
                    <th class="_bgColor" data-bgColor="#d0cece">본인</th>
                    <th class="_bgColor" data-bgColor="#d0cece">운영자</th>
                </tr>
                </thead>
                <tbody id="timeTableBody"></tbody>
            </table>
        </div>

        <div class="col-md-8 no-padding">
            <span class="font-bold">◈선물 별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col width="7.2%"/><col width="11.6%"/><col width="11.6%"/><col width="11.6%"/><col width="11.6%"/>
                    <col width="11.6%"/><col width="11.6%"/><col width="11.6%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th colspan="2" class="_bgColor _sex_male" data-bgColor="#b4c7e7"></th>
                    <th colspan="2" class="_bgColor _sex_female" data-bgColor="#b4c7e7"></th>
                    <th colspan="2" class="_bgColor _sex_none" data-bgColor="#b4c7e7"></th>
                    <th colspan="2" class="_bgColor" data-bgColor="#d0cece">소계</th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgColor="#e9ebf5">건수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">달수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">건수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">달수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">건수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">달수</th>
                    <th class="_bgColor" data-bgColor="#d0cece">건수</th>
                    <th class="_bgColor" data-bgColor="#d0cece">달수</th>
                </tr>
                </thead>
                <tbody  id="giftListBody">
                </tbody>
            </table>
        </div>

        <div class="col-md-8 no-padding">
            <span class="font-bold">◈연령대 별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col width="7.2%"/><col width="11.1%"/><col width="11.1%"/><col width="11.1%"/><col width="11.1%"/>
                    <col width="11.1%"/><col width="11.1%"/><col width="11.1%"/><col width="11.1%"/>
                </colgroup>
                <thead>
                <tr>
                    <th class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">12세~16세</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">17세~19세</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">20세~25세</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">26세~30세</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">31세~35세</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">36세~40세</th>
                    <th class="_bgColor" data-bgColor="#b4c7e7">40세이상</th>
                    <th class="_bgColor" data-bgColor="#d0cece">누적합계</th>
                </tr>
                </thead>
                <tbody id="ageListBody">
                </tbody>
            </table>
        </div>

        <div class="col-md-11 no-padding">
            <span class="font-bold">◈클립 주제 별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
                    <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
                    <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
                    <col width="5.2%"/><col width="5.2%"/><col width="5.2%"/><col width="5.2%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th colspan="2" class="_bgColor subject01" data-bgColor="#b4c7e7">01</th>
                    <th colspan="2" class="_bgColor subject02" data-bgColor="#b4c7e7">02</th>
                    <th colspan="2" class="_bgColor subject03" data-bgColor="#b4c7e7">03</th>
                    <th colspan="2" class="_bgColor subject04" data-bgColor="#b4c7e7">04</th>
                    <th colspan="2" class="_bgColor subject05" data-bgColor="#b4c7e7">05</th>
                    <th colspan="2" class="_bgColor subject06" data-bgColor="#b4c7e7">06</th>
                    <th colspan="2" class="_bgColor subject07" data-bgColor="#b4c7e7">07</th>
                    <th colspan="2" class="_bgColor subject08" data-bgColor="#b4c7e7">08</th>
                    <th colspan="2" class="_bgColor" data-bgColor="#d0cece">누적합계</th>
                </tr>
                <tr>
                    <th class="_bgColor" data-bgColor="#e9ebf5">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">청취자 수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">청취자 수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">청취자 수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">청취자 수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">청취자 수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">청취자 수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">청취자 수</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#e9ebf5">청취자 수</th>
                    <th class="_bgColor" data-bgColor="#d0cece">등록(삭제)</th>
                    <th class="_bgColor" data-bgColor="#d0cece">청취자 수</th>
                </tr>
                </thead>
                <tbody id="typeTimeTableBody"></tbody>
            </table>
        </div>

        <div class="col-md-8 no-padding">
            <span class="font-bold">◈플랫폼 별</span>
            <table class="table table-bordered _tableHeight" data-height="23px">
                <colgroup>
                    <col width="7.2%"/><col width="11.1%"/><col width="11.1%"/><col width="11.1%"/><col width="11.1%"/>
                    <col width="11.1%"/><col width="11.1%"/><col width="11.1%"/><col width="11.1%"/>
                </colgroup>
                <thead>
                <tr>
                    <th rowspan="2" class="_bgColor" data-bgColor="#b4c7e7">구분</th>
                    <th colspan="3" class="_bgColor" data-bgColor="#b4c7e7">클립 등록 (삭제) 수</th>
                    <th rowspan="2" class="_bgColor" data-bgColor="#d0cece">소계</th>
                    <th colspan="3" class="_bgColor" data-bgColor="#b4c7e7">클립 청취자 수</th>
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
                <tbody id="platformTimeListBody">
                </tbody>
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
        // getTimeList();
    });

    var subjectCodeList = "";

    function getTimeList(){
        var data = dataSet();
        data.slctType = 0;

        var timeDay = week[moment(data.startDate).add('days', 0).day()];

        $("._searchDate").html(moment($("#startDate").val()).format('YYYY년 MM월 DD일') + "(" + timeDay + ")");

        util.getAjaxData("time", "/rest/clip/status/info/time", data, fn_time_success);

        // 선물 현황
        util.getAjaxData("clipStatusGift", "/rest/clip/status/gift", data, fn_clipStatusGift_success);
        // 연령별
        util.getAjaxData("age", "/rest/clip/status/info/age", data, fn_clipStatusAge_success);
        // 주제별
        util.getAjaxData("type", "/rest/clip/status/info/type", data, fn_typeTime_success);
        // 플랫폼 별
        util.getAjaxData("platform", "/rest/clip/status/info/platform", data, fn_platformTimeList_success);
    }

    function fn_time_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        var tableBody = $("#timeTableBody");

        tableBody.empty();
        if(!isDataEmpty){
            var template = $('#tmp_timeTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            tableBody.append(totalHtml);
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].index = common.lpad(Number(moment().format("HH")),2,"0");
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD"),2,"0"));
            response.data.detailList[i].nowHour = Number(moment().format("HH"));
        }
        //현재 객체 배열을 정렬
        response.data.detailList.sort(function (a, b) {
            return a.index < b.index ? 1 : -1;
        });

        var tmp_create_totalCnt = 0;
        var tmp_listener_totalCnt = 0;
        for(var i=0;i<response.data.detailList.length;i++){
            var create_totalCnt = [
                response.data.detailList[i].create_mCnt,
                response.data.detailList[i].create_fCnt,
                response.data.detailList[i].create_nCnt,
            ];
            if(common.getListSum(create_totalCnt) != 0 ){
                response.data.detailList[i].create_totalCnt = common.getListSum(create_totalCnt);
                response.data.detailList[i].create_accuTotalCnt = tmp_create_totalCnt + common.getListSum(create_totalCnt);
                tmp_create_totalCnt = tmp_create_totalCnt + common.getListSum(create_totalCnt);
            }else{
                response.data.detailList[i].create_totalCnt = 0;
                response.data.detailList[i].create_accuTotalCnt = 0;
            }
            var listener_totalCnt = [
                response.data.detailList[i].listener_mCnt,
                response.data.detailList[i].listener_fCnt,
                response.data.detailList[i].listener_nCnt,
            ];
            if(common.getListSum(listener_totalCnt) != 0){
                response.data.detailList[i].listener_totalCnt = common.getListSum(listener_totalCnt);
                response.data.detailList[i].listener_accuTotalCnt = tmp_listener_totalCnt + common.getListSum(listener_totalCnt);
                tmp_listener_totalCnt = tmp_listener_totalCnt + common.getListSum(listener_totalCnt);
            }else{
                response.data.detailList[i].listener_accuTotalCnt = 0;
                response.data.detailList[i].listener_totalCnt = 0;
            }
        }
        //현재 객체 배열을 정렬
        response.data.detailList.sort(function (a, b) {
            return a.index < b.index ? 1 : -1;
        });

        var template = $('#tmp_timeDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        tableBody.append(html);

        if(isDataEmpty){
            $("#timeTableBody td:last").remove();
        }else{
            tableBody.append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    function fn_clipStatusGift_success(dst_id, response) {
        dalbitLog(response);
        var isDataEmpty = response.data.detailList == null;
        $("#giftListBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_giftTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#giftListBody").append(totalHtml);

            response.data.detailList.slctType = $('input:radio[name="slctType"]:checked').val();
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].day = response.data.detailList[i].daily.substr(8,2);

            toDay = week[moment(response.data.detailList[i].daily.replace(/-/gi,".")).add('days', 0).day()];
            if(toDay == "토"){
                toDay = '<span class="_fontColor" data-fontColor="blue">' + response.data.detailList[i].daily.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else if(toDay == "일"){
                toDay = '<span class="_fontColor" data-fontColor="red">' + response.data.detailList[i].daily.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else{
                toDay = response.data.detailList[i].daily.replace(/-/gi,".") + "(" + toDay + ")";
            }

            response.data.detailList[i].date = toDay;
        }

        var template = $('#tmp_giftDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#giftListBody").append(html);

        if(isDataEmpty){
            $("#giftListBody td:last").remove();
        }else{
            $("#giftListBody").append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    function fn_clipStatusAge_success(dst_id, response) {
        dalbitLog(response);
        var isDataEmpty = response.data.detailList == null;
        $("#ageListBody").empty();
        if(!isDataEmpty){
            var template = $('#tmp_ageTotal').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#ageListBody").append(totalHtml);

            response.data.detailList.slctType = $('input:radio[name="slctType"]:checked').val();
        }

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].day = response.data.detailList[i].date.substr(8,2);

            toDay = week[moment(response.data.detailList[i].date.replace(/-/gi,".")).add('days', 0).day()];
            if(toDay == "토"){
                toDay = '<span class="_fontColor" data-fontColor="blue">' + response.data.detailList[i].date.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else if(toDay == "일"){
                toDay = '<span class="_fontColor" data-fontColor="red">' + response.data.detailList[i].date.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else{
                toDay = response.data.detailList[i].date.replace(/-/gi,".") + "(" + toDay + ")";
            }

            response.data.detailList[i].date = toDay;
        }

        var template = $('#tmp_ageDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#ageListBody").append(html);

        if(isDataEmpty){
            $("#ageListBody td:last").remove();
        }else{
            $("#ageListBody").append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    function fn_platformTimeList_success(dst_id, response) {
        dalbitLog(response);
        var isDataEmpty = response.data.detailList == null;
        $("#platformTimeListBody").empty();

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD"),2,"0"));
            response.data.detailList[i].nowHour = Number(moment().format("HH"));


            response.data.detailList[i].reg_total_cnt =  response.data.detailList[i].reg_and_cnt
                                                                        + response.data.detailList[i].reg_ios_cnt
                                                                        + response.data.detailList[i].reg_pc_cnt;
            response.data.detailList[i].del_total_cnt =  response.data.detailList[i].del_and_cnt
                                                                        + response.data.detailList[i].del_ios_cnt
                                                                        + response.data.detailList[i].del_pc_cnt;
            response.data.detailList[i].listen_total_cnt =  response.data.detailList[i].listen_and_cnt
                                                                        + response.data.detailList[i].listen_ios_cnt
                                                                        + response.data.detailList[i].listen_pc_cnt;

            response.data.totalInfo.sum_reg_total_cnt +=  response.data.detailList[i].reg_total_cnt;
            response.data.totalInfo.sum_del_total_cnt +=  response.data.detailList[i].del_total_cnt;
            response.data.totalInfo.sum_listen_total_cnt +=  response.data.detailList[i].listen_total_cnt;

        }

        if(!isDataEmpty){
            var template = $('#tmp_platformTime').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            $("#platformTimeListBody").append(totalHtml);

            response.data.detailList.slctType = slctType;
        }

        var template = $('#tmp_platformTimeDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        $("#platformTimeListBody").append(html);

        if(isDataEmpty){
            $("#platformTimeListBody td:last").remove();
        }else{
            $("#platformTimeListBody").append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();
    }

    function fn_typeTime_success(data, response){
        var isDataEmpty = response.data.detailList == null;
        var tableBody = $("#typeTimeTableBody");

        tableBody.empty();

        for(var i=0;i<response.data.detailList.length;i++){
            response.data.detailList[i].nowMonth = Number(moment().format("MM"));
            response.data.detailList[i].nowDay = common.lpad(Number(moment().format("DD")),2,"0");
            response.data.detailList[i].nowHour = Number(moment().format("HH"));

            response.data.detailList[i].day = response.data.detailList[i].the_date.substr(8,2);

            toDay = week[moment(response.data.detailList[i].the_date.replace(/-/gi,".")).add('days', 0).day()];
            if(toDay == "토"){
                toDay = '<span class="_fontColor" data-fontColor="blue">' + response.data.detailList[i].the_date.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else if(toDay == "일"){
                toDay = '<span class="_fontColor" data-fontColor="red">' + response.data.detailList[i].the_date.replace(/-/gi,".") + "(" + toDay + ")" + '</span>';
            }else{
                toDay = response.data.detailList[i].the_date.replace(/-/gi,".") + "(" + toDay + ")";
            }

            response.data.detailList[i].date = toDay;

            response.data.detailList[i].reg_total_cnt =  response.data.detailList[i].reg_01_cnt
                                                                    + response.data.detailList[i].reg_02_cnt
                                                                    + response.data.detailList[i].reg_03_cnt
                                                                    + response.data.detailList[i].reg_04_cnt
                                                                    + response.data.detailList[i].reg_05_cnt
                                                                    + response.data.detailList[i].reg_06_cnt
                                                                    + response.data.detailList[i].reg_07_cnt
                                                                    + response.data.detailList[i].reg_08_cnt
                                                                    + response.data.detailList[i].reg_09_cnt
                                                                    + response.data.detailList[i].reg_10_cnt ;
            response.data.detailList[i].del_total_cnt =  response.data.detailList[i].del_01_cnt
                                                                    + response.data.detailList[i].del_02_cnt
                                                                    + response.data.detailList[i].del_03_cnt
                                                                    + response.data.detailList[i].del_04_cnt
                                                                    + response.data.detailList[i].del_05_cnt
                                                                    + response.data.detailList[i].del_06_cnt
                                                                    + response.data.detailList[i].del_07_cnt
                                                                    + response.data.detailList[i].del_08_cnt
                                                                    + response.data.detailList[i].del_09_cnt
                                                                    + response.data.detailList[i].del_10_cnt ;
            response.data.detailList[i].play_total_cnt =  response.data.detailList[i].play_01_cnt
                                                                    + response.data.detailList[i].play_02_cnt
                                                                    + response.data.detailList[i].play_03_cnt
                                                                    + response.data.detailList[i].play_04_cnt
                                                                    + response.data.detailList[i].play_05_cnt
                                                                    + response.data.detailList[i].play_06_cnt
                                                                    + response.data.detailList[i].play_07_cnt
                                                                    + response.data.detailList[i].play_08_cnt
                                                                    + response.data.detailList[i].play_09_cnt
                                                                    + response.data.detailList[i].play_10_cnt ;

            response.data.totalInfo.sum_reg_total_cnt +=  response.data.detailList[i].reg_total_cnt;
            response.data.totalInfo.sum_del_total_cnt +=  response.data.detailList[i].del_total_cnt;
            response.data.totalInfo.sum_play_total_cnt +=  response.data.detailList[i].play_total_cnt;
        }

        if(!isDataEmpty){
            var template = $('#tmp_typeTime').html();
            var templateScript = Handlebars.compile(template);
            var totalContext = response.data.totalInfo;
            var totalHtml = templateScript(totalContext);
            tableBody.append(totalHtml);
        }

        var template = $('#tmp_typeTimeDetailList').html();
        var templateScript = Handlebars.compile(template);
        var detailContext = response.data.detailList;
        var html=templateScript(detailContext);
        tableBody.append(html);

        if(isDataEmpty){
            $("#typeTimeTableBody td:last").remove();
        }else{
            tableBody.append(totalHtml);
        }

        ui.tableHeightSet();
        ui.paintColor();

        getClipSubjectTypeCodeDefine();
    }


    // subject code 조회
    function getClipSubjectTypeCodeDefine(){
        var data = {};
        data.type="clip_type";
        data.order = "asc";
        data.is_ues = "1";
        util.getAjaxData("codeList", "/common/codeList", data, fn_ClipSubjectTypeCode_success);
    }
    function fn_ClipSubjectTypeCode_success(dst_id, response){
        console.log("=========================")
        console.log(response);
        subjectCodeList = response.data;

        console.log(tabId);
        subjectCodeList.forEach(function(code){
            $(".subject" + code.value).html(code.code);
        });
    }

</script>

<script type="text/x-handlebars-template" id="tmp_timeTotal">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td class="_fontColor" data-fontColor="blue">{{addComma sum_maleCnt}}</td>
        <td class="_fontColor" data-fontColor="blue">{{addComma sum_open_reg_maleCnt}}</td>
        <td class="_fontColor" data-fontColor="blue">{{addComma sum_notopen_reg_maleCnt}}</td>
        <td class="_fontColor" data-fontColor="blue">{{addComma sum_mem_del_maleCnt}}</td>
        <td class="_fontColor" data-fontColor="blue">{{addComma sum_op_del_maleCnt}}</td>

        <td class="_fontColor" data-fontColor="red">{{addComma sum_femaleCnt}}</td>
        <td class="_fontColor" data-fontColor="red">{{addComma sum_open_reg_femaleCnt}}</td>
        <td class="_fontColor" data-fontColor="red">{{addComma sum_notopen_reg_femaleCnt}}</td>
        <td class="_fontColor" data-fontColor="red">{{addComma sum_mem_del_femaleCnt}}</td>
        <td class="_fontColor" data-fontColor="red">{{addComma sum_op_del_femaleCnt}}</td>

        <td class="_fontColor">{{addComma sum_noneCnt}}</td>
        <td class="_fontColor">{{addComma sum_open_reg_noneCnt}}</td>
        <td class="_fontColor">{{addComma sum_notopen_reg_noneCnt}}</td>
        <td class="_fontColor">{{addComma sum_mem_del_noneCnt}}</td>
        <td class="_fontColor">{{addComma sum_op_del_noneCnt}}</td>

        <td class="_fontColor">{{addComma sum_totalCnt}}</td>
        <td class="_fontColor">{{addComma sum_open_reg_totalCnt}}</td>
        <td class="_fontColor">{{addComma sum_notopen_reg_totalCnt}}</td>
        <td class="_fontColor">{{addComma sum_mem_del_totalCnt}}</td>
        <td class="_fontColor">{{addComma sum_op_del_totalCnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_timeDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowHour '==' the_hr}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowHour '==' the_hr}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowHour '!=' the_hr}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{data.the_hr}}시
        </td>
        <td class="_fontColor" data-fontColor="blue">{{addComma maleCnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="blue">{{addComma open_reg_maleCnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="blue">{{addComma notopen_reg_maleCnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="blue">{{addComma mem_del_maleCnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="blue">{{addComma op_del_maleCnt 'Y'}}</td>

        <td class="_fontColor" data-fontColor="red">{{addComma femaleCnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="red">{{addComma open_reg_femaleCnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="red">{{addComma notopen_reg_femaleCnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="red">{{addComma mem_del_femaleCnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="red">{{addComma op_del_femaleCnt 'Y'}}</td>

        <td>{{addComma noneCnt 'Y'}}</td>
        <td>{{addComma open_reg_noneCnt 'Y'}}</td>
        <td>{{addComma notopen_reg_noneCnt 'Y'}}</td>
        <td>{{addComma mem_del_noneCnt 'Y'}}</td>
        <td>{{addComma op_del_noneCnt 'Y'}}</td>

        <td>{{addComma totalCnt 'Y'}}</td>
        <td>{{addComma open_reg_totalCnt 'Y'}}</td>
        <td>{{addComma notopen_reg_totalCnt 'Y'}}</td>
        <td>{{addComma mem_del_totalCnt 'Y'}}</td>
        <td>{{addComma op_del_totalCnt 'Y'}}</td>

    </tr>
    {{else}}
    <tr>
        <td colspan="20" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>

<script type="text/x-handlebars-template" id="tmp_giftTotal">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td class="_fontColor" data-fontColor="blue">{{addComma sum_maleGiftCnt}}</td>
        <td class="_fontColor" data-fontColor="blue">{{addComma sum_maleGiftAmount}}</td>
        <td class="_fontColor" data-fontColor="red">{{addComma sum_femaleGiftCnt}}</td>
        <td class="_fontColor" data-fontColor="red">{{addComma sum_femaleGiftAmount}}</td>
        <td>{{addComma sum_noneGiftCnt}}</td>
        <td>{{addComma sum_noneGiftAmount}}</td>
        <td>{{addComma sum_totalGiftCnt}}</td>
        <td>{{addComma sum_totalGiftAmount}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_giftDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowHour '==' hour}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowHour '==' hour}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowHour '!=' hour}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{data.hour}}시
        </td>
        <td class="_fontColor" data-fontColor="blue">{{addComma maleGiftCnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="blue">{{addComma maleGiftAmount 'Y'}}</td>
        <td class="_fontColor" data-fontColor="red">{{addComma femaleGiftCnt 'Y'}}</td>
        <td class="_fontColor" data-fontColor="red">{{addComma femaleGiftAmount 'Y'}}</td>
        <td>{{addComma noneGiftCnt 'Y'}}</td>
        <td>{{addComma noneGiftAmount 'Y'}}</td>
        <td>{{addComma totalGiftCnt 'Y'}}</td>
        <td>{{addComma totalGiftAmount 'Y'}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="8" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>

<script type="text/x-handlebars-template" id="tmp_ageTotal">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td>{{addComma sum_reg_12_16_cnt}} ({{addComma sum_del_12_16_cnt}})</td>
        <td>{{addComma sum_reg_17_19_cnt}} ({{addComma sum_del_17_19_cnt}})</td>
        <td>{{addComma sum_reg_20_25_cnt}} ({{addComma sum_del_20_25_cnt}})</td>
        <td>{{addComma sum_reg_26_30_cnt}} ({{addComma sum_del_26_30_cnt}})</td>
        <td>{{addComma sum_reg_31_35_cnt}} ({{addComma sum_del_31_35_cnt}})</td>
        <td>{{addComma sum_reg_36_40_cnt}} ({{addComma sum_del_36_40_cnt}})</td>
        <td>{{addComma sum_reg_41_00_cnt}} ({{addComma sum_del_41_00_cnt}})</td>
        <td>{{addComma sum_reg_total_cnt}} ({{addComma sum_del_total_cnt}})</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_ageDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowHour '==' hour}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
    <td {{#dalbit_if nowHour '==' hour}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
    {{#dalbit_if nowHour '!=' hour}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
    {{data.hour}}시
    </td>
        <td>{{#dalbit_if reg_12_16_cnt '!=' '0'}}{{addComma reg_12_16_cnt}} ({{addComma del_12_16_cnt}}){{else}}{{#dalbit_if del_12_16_cnt '!=' '0'}}{{addComma reg_12_16_cnt}} ({{addComma del_12_16_cnt}}){{/dalbit_if}}{{/dalbit_if}}</td>
        <td>{{#dalbit_if reg_17_19_cnt '!=' '0'}}{{addComma reg_17_19_cnt}} ({{addComma del_17_19_cnt}}){{else}}{{#dalbit_if del_17_19_cnt '!=' '0'}}{{addComma reg_17_19_cnt}} ({{addComma del_17_19_cnt}}){{/dalbit_if}}{{/dalbit_if}}</td>
        <td>{{#dalbit_if reg_20_25_cnt '!=' '0'}}{{addComma reg_20_25_cnt}} ({{addComma del_20_25_cnt}}){{else}}{{#dalbit_if del_20_25_cnt '!=' '0'}}{{addComma reg_20_25_cnt}} ({{addComma del_20_25_cnt}}){{/dalbit_if}}{{/dalbit_if}}</td>
        <td>{{#dalbit_if reg_26_30_cnt '!=' '0'}}{{addComma reg_26_30_cnt}} ({{addComma del_26_30_cnt}}){{else}}{{#dalbit_if del_26_30_cnt '!=' '0'}}{{addComma reg_26_30_cnt}} ({{addComma del_26_30_cnt}}){{/dalbit_if}}{{/dalbit_if}}</td>
        <td>{{#dalbit_if reg_31_35_cnt '!=' '0'}}{{addComma reg_31_35_cnt}} ({{addComma del_31_35_cnt}}){{else}}{{#dalbit_if del_31_35_cnt '!=' '0'}}{{addComma reg_31_35_cnt}} ({{addComma del_31_35_cnt}}){{/dalbit_if}}{{/dalbit_if}}</td>
        <td>{{#dalbit_if reg_36_40_cnt '!=' '0'}}{{addComma reg_36_40_cnt}} ({{addComma del_36_40_cnt}}){{else}}{{#dalbit_if del_36_40_cnt '!=' '0'}}{{addComma reg_36_40_cnt}} ({{addComma del_36_40_cnt}}){{/dalbit_if}}{{/dalbit_if}}</td>
        <td>{{#dalbit_if reg_41_00_cnt '!=' '0'}}{{addComma reg_41_00_cnt}} ({{addComma del_41_00_cnt}}){{else}}{{#dalbit_if del_41_00_cnt '!=' '0'}}{{addComma reg_41_00_cnt}} ({{addComma del_41_00_cnt}}){{/dalbit_if}}{{/dalbit_if}}</td>
        <td>{{#dalbit_if reg_total_cnt '!=' '0'}}{{addComma reg_total_cnt}} ({{addComma del_total_cnt}}){{else}}{{#dalbit_if del_total_cnt '!=' '0'}}{{addComma reg_total_cnt}} ({{addComma del_total_cnt}}){{/dalbit_if}}{{/dalbit_if}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="11" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>

<script type="text/x-handlebars-template" id="tmp_platformTime">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td>{{addComma sum_reg_pc_cnt}} ({{addComma sum_del_pc_cnt}})</td>
        <td>{{addComma sum_reg_and_cnt}} ({{addComma sum_del_and_cnt}})</td>
        <td>{{addComma sum_reg_ios_cnt}} ({{addComma sum_del_ios_cnt}})</td>
        <td>{{addComma sum_reg_total_cnt}} ({{addComma sum_del_total_cnt}})</td>
        <td>{{addComma sum_listen_pc_cnt}}</td>
        <td>{{addComma sum_listen_and_cnt}}</td>
        <td>{{addComma sum_listen_ios_cnt}}</td>
        <td>{{addComma sum_listen_total_cnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_platformTimeDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowHour '==' the_hr}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
        <td {{#dalbit_if nowHour '==' the_hr}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
        {{#dalbit_if nowHour '!=' the_hr}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
        {{data.the_hr}}시
        </td>
        <td>{{#dalbit_if reg_pc_cnt '!=' '0'}}{{addComma reg_pc_cnt }} ({{addComma del_pc_cnt }}){{else}}{{#dalbit_if del_pc_cnt '!=' '0'}}{{addComma reg_pc_cnt }} ({{addComma del_pc_cnt }}){{/dalbit_if}}{{/dalbit_if}}</td>
        <td>{{#dalbit_if reg_and_cnt '!=' '0'}}{{addComma reg_and_cnt }} ({{addComma del_and_cnt }}){{else}}{{#dalbit_if del_and_cnt '!=' '0'}}{{addComma reg_and_cnt }} ({{addComma del_and_cnt }}){{/dalbit_if}}{{/dalbit_if}}</td>
        <td>{{#dalbit_if reg_ios_cnt '!=' '0'}}{{addComma reg_ios_cnt }} ({{addComma del_ios_cnt }}){{else}}{{#dalbit_if del_ios_cnt '!=' '0'}}{{addComma reg_ios_cnt }} ({{addComma del_ios_cnt }}){{/dalbit_if}}{{/dalbit_if}}</td>
        <td>{{#dalbit_if reg_total_cnt '!=' '0'}}{{addComma reg_total_cnt }} ({{addComma del_total_cnt }}){{else}}{{#dalbit_if del_total_cnt '!=' '0'}}{{addComma reg_total_cnt }} ({{addComma del_total_cnt }}){{/dalbit_if}}{{/dalbit_if}}</td>

        <td>{{addComma listen_pc_cnt 'Y'}}</td>
        <td>{{addComma listen_and_cnt 'Y'}}</td>
        <td>{{addComma listen_ios_cnt 'Y'}}</td>
        <td>{{addComma listen_total_cnt 'Y'}}</td>
    </tr>
    {{/each}}
</script>

<script type="text/x-handlebars-template" id="tmp_typeTime">
    <tr class="font-bold _bgColor" data-bgColor="#d0cece">
        <td>총합</td>
        <td>{{addComma sum_reg_01_cnt}} ({{addComma sum_del_01_cnt}})</td>
        <td>{{addComma sum_play_01_cnt}}</td>
        <td>{{addComma sum_reg_02_cnt}} ({{addComma sum_del_02_cnt}})</td>
        <td>{{addComma sum_play_02_cnt}}</td>
        <td>{{addComma sum_reg_03_cnt}} ({{addComma sum_del_03_cnt}})</td>
        <td>{{addComma sum_play_03_cnt}}</td>
        <td>{{addComma sum_reg_04_cnt}} ({{addComma sum_del_04_cnt}})</td>
        <td>{{addComma sum_play_04_cnt}}</td>
        <td>{{addComma sum_reg_05_cnt}} ({{addComma sum_del_05_cnt}})</td>
        <td>{{addComma sum_play_05_cnt}}</td>
        <td>{{addComma sum_reg_06_cnt}} ({{addComma sum_del_06_cnt}})</td>
        <td>{{addComma sum_play_06_cnt}}</td>
        <td>{{addComma sum_reg_07_cnt}} ({{addComma sum_del_07_cnt}})</td>
        <td>{{addComma sum_play_07_cnt}}</td>
        <td>{{addComma sum_reg_08_cnt}} ({{addComma sum_del_08_cnt}})</td>
        <td>{{addComma sum_play_08_cnt}}</td>
        <td>{{addComma sum_reg_total_cnt}} ({{addComma sum_del_total_cnt}})</td>
        <td>{{addComma sum_play_total_cnt}}</td>
    </tr>
</script>

<script type="text/x-handlebars-template" id="tmp_typeTimeDetailList">
    {{#each this as |data|}}
    <tr {{#dalbit_if nowHour '==' the_hr}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}>
    <td {{#dalbit_if nowHour '==' the_hr}} class="font-bold _bgColor" data-bgColor="#fff2cc"  {{/dalbit_if}}
    {{#dalbit_if nowHour '!=' the_hr}} class="font-bold _bgColor" data-bgColor="#d8e2f3"  {{/dalbit_if}}>
    {{data.the_hr}}시
    </td>
    <td>{{#dalbit_if reg_01_cnt '!=' '0'}}{{addComma reg_01_cnt }} ({{addComma del_01_cnt }}){{else}}{{#dalbit_if del_01_cnt '!=' '0'}}{{addComma reg_01_cnt }} ({{addComma del_01_cnt }}){{/dalbit_if}}{{/dalbit_if}}</td>
    <td>{{addComma play_01_cnt 'Y'}}</td>
    <td>{{#dalbit_if reg_02_cnt '!=' '0'}}{{addComma reg_02_cnt }} ({{addComma del_02_cnt }}){{else}}{{#dalbit_if del_02_cnt '!=' '0'}}{{addComma reg_02_cnt }} ({{addComma del_02_cnt }}){{/dalbit_if}}{{/dalbit_if}}</td>
    <td>{{addComma play_02_cnt 'Y'}}</td>
    <td>{{#dalbit_if reg_03_cnt '!=' '0'}}{{addComma reg_03_cnt }} ({{addComma del_03_cnt }}){{else}}{{#dalbit_if del_03_cnt '!=' '0'}}{{addComma reg_03_cnt }} ({{addComma del_03_cnt }}){{/dalbit_if}}{{/dalbit_if}}</td>
    <td>{{addComma play_03_cnt 'Y'}}</td>
    <td>{{#dalbit_if reg_04_cnt '!=' '0'}}{{addComma reg_04_cnt }} ({{addComma del_04_cnt }}){{else}}{{#dalbit_if del_04_cnt '!=' '0'}}{{addComma reg_04_cnt }} ({{addComma del_04_cnt }}){{/dalbit_if}}{{/dalbit_if}}</td>
    <td>{{addComma play_04_cnt 'Y'}}</td>
    <td>{{#dalbit_if reg_05_cnt '!=' '0'}}{{addComma reg_05_cnt }} ({{addComma del_05_cnt }}){{else}}{{#dalbit_if del_05_cnt '!=' '0'}}{{addComma reg_05_cnt }} ({{addComma del_05_cnt }}){{/dalbit_if}}{{/dalbit_if}}</td>
    <td>{{addComma play_05_cnt 'Y'}}</td>
    <td>{{#dalbit_if reg_06_cnt '!=' '0'}}{{addComma reg_06_cnt }} ({{addComma del_06_cnt }}){{else}}{{#dalbit_if del_06_cnt '!=' '0'}}{{addComma reg_06_cnt }} ({{addComma del_06_cnt }}){{/dalbit_if}}{{/dalbit_if}}</td>
    <td>{{addComma play_06_cnt 'Y'}}</td>
    <td>{{#dalbit_if reg_07_cnt '!=' '0'}}{{addComma reg_07_cnt }} ({{addComma del_07_cnt }}){{else}}{{#dalbit_if del_07_cnt '!=' '0'}}{{addComma reg_07_cnt }} ({{addComma del_07_cnt }}){{/dalbit_if}}{{/dalbit_if}}</td>
    <td>{{addComma play_07_cnt 'Y'}}</td>
    <td>{{#dalbit_if reg_08_cnt '!=' '0'}}{{addComma reg_08_cnt }} ({{addComma del_08_cnt }}){{else}}{{#dalbit_if del_08_cnt '!=' '0'}}{{addComma reg_08_cnt }} ({{addComma del_08_cnt }}){{/dalbit_if}}{{/dalbit_if}}</td>
    <td>{{addComma play_08_cnt 'Y'}}</td>
    <td>{{#dalbit_if reg_total_cnt '!=' '0'}}{{addComma reg_total_cnt }} ({{addComma del_total_cnt }}){{else}}{{#dalbit_if del_total_cnt '!=' '0'}}{{addComma reg_total_cnt }} ({{addComma del_total_cnt }}){{/dalbit_if}}{{/dalbit_if}}</td>
    <td>{{addComma play_total_cnt 'Y'}}</td>
    </tr>
    {{else}}
    <tr>
        <td colspan="11" class="noData">{{isEmptyData}}<td>
    </tr>
    {{/each}}
</script>