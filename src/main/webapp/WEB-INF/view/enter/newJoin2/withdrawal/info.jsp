<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<%
    String in_tabType = request.getParameter("tabType");
%>

<div id="wrapper">
    <div id="page-wrapper" class="col-lg-8 no-padding">
        <div class="container-fluid">
            <form id="searchForm">
                <div class="row form-inline">
                    <div class="widget widget-table searchBoxArea">
                        <table>
                            <tr>
                                <th rowspan="2" style="background-color:#4472c4;color:#e9ee17;width: 70px">
                                    <i class="fa fa-search"></i><br/>검색
                                </th>
                                <th id="th_bottonList">
                                    <jsp:include page="../../../searchArea/daySearchFunction.jsp"/>
                                    <div>
                                        <div id="div_dayButton" style="display: none"><jsp:include page="../../../searchArea/daySearchArea.jsp"/></div>
                                        <div id="div_monthButton" ><jsp:include page="../../../searchArea/monthSearchArea.jsp"/></div>
                                    </div>
                                </th>
                            </tr>
                            <tr>
                                <td style="text-align: left">

                                    <jsp:include page="../../../searchArea/dateRangeSearchArea.jsp"/>

                                    <input type="text" class="form-control" id="onedayDate" name="onedayDate" style="display: none">

                                    <input id="monthDate" type="text" class="form-control" style="width: 196px;"/>

                                    <input class="hide" name="startDate" id="startDate" style="width: 100px">
                                    <input class="hide" name="endDate" id="endDate" style="width: 100px">
                                    <%--<input name="startDate" id="startDate" style="width: 100px">--%>
                                    <%--<input name="endDate" id="endDate" style="width: 100px">--%>
                                    <label><input type="text" class="form-control" name="searchText" id="searchText" placeholder="검색어를 입력해주세요." style="display: none"></label>

                                    <button type="button" class="btn btn-success" id="bt_search">검색</button>
                                    <a href="javascript://" class="_prevSearch">[이전]</a>
                                    <a href="javascript://" class="_todaySearch">[오늘]</a>
                                    <a href="javascript://" class="_nextSearch">[다음]</a>

                                    <span id="searchCheck" style="display: none">
                                        <label class="control-inline fancy-checkbox custom-color-green">
                                            <input type="checkbox" name="search_testId" id="search_testId" value="1" checked="true">
                                            <span>테스트 아이디 제외</span>
                                        </label>

                                        <label class="control-inline fancy-checkbox custom-color-green">
                                            <input type="checkbox" name="search_joinPath" id="search_joinPath" value="1">
                                            <span>광고유입</span>
                                        </label>
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="col-lg-4" id="stateSummary">
        <span id="summary"></span>
    </div>

    <div class="col-lg-4" id="joinListSummary" style="display: none">
        <span id="joinList_summaryArea"></span>
    </div>

    <!-- tab -->
    <div class="no-padding" id="infoTab">
        <jsp:include page="infoTab.jsp"/>
    </div>
    <!-- //tab -->
</div>

<script type="text/javascript" src="/js/code/enter/joinCodeList.js?${dummyData}"></script>
<script type="text/javascript" src="/js/util/statUtil.js?${dummyData}"></script>
<script type="text/javascript" src="/js/handlebars/statusHelper.js?${dummyData}"></script>

<script type="text/javascript">
    var dateTime = new Date();
    dateTime = moment(dateTime).format("YYYY.MM.DD");
    var week = ['일', '월', '화', '수', '목', '금', '토'];
    var toDay = week[moment(new Date()).day()];
    setTimeDate(dateTime);

    var slctType = 1;

    var tabType = <%=in_tabType%>;

    $(function(){
        setDayButton();
    });

    function setTimeDate(dateTime){
        $("#onedayDate").val(dateTime);
        $("#startDate").val(dateTime);
        $("#endDate").val(dateTime);
        $("#displayDate").val(dateTime + " - " + dateTime);

        toDay = week[moment($("#startDate").val()).add('days', 0).day()];
        $("._searchDate").html(dateTime + " (" + toDay + ")");
    }

    function setRangeDate(displayDate, startDate, endDate){
        $("#onedayDate").val(startDate);
        $("#startDate").val(startDate);
        $("#endDate").val(endDate);
        $("#displayDate").val(startDate.substr(0,7));
        $("#yearDate").val(startDate.substr(0,4));
    }

    $(document).on('click', '._prevSearch', function(){
        prevNext(true);
    });

    $(document).on('click', '._nextSearch', function(){
        prevNext(false);
    });

    $(document).on('click', '._todaySearch', function(){

        if(tabId == 'tab_time'){
            slctType = 0;
        }else if(tabId == 'tab_calendar' || tabId == 'tab_month') {
            slctType = 1;
        }else if(tabId == 'tab_list') {
            slctType = 3;
        }
        dateType();
    });

    function radioChange(){
        dateType(slctType);
        if(slctType == 0){
            $("#onedayDate").show();
            $("#monthDate").hide();
            $("#rangeDatepicker").hide();
            $("#startDate").val($("#onedayDate").val());
            $("#endDate").val($("#onedayDate").val());
        }else{
            if(slctType == 1) {
                // 일별 -----------------------------------
                $("#onedayDate").hide();
                $("#monthDate").show();
                $("#rangeDatepicker").hide();

            }else if(slctType == 3){
                // 목록 ----------------------------------
                $("#onedayDate").hide();
                $("#monthDate").hide();
                $("#rangeDatepicker").show();
                setTimeDate(dateTime);
            }
        }
    }

    function prevNext(isPrev){
        var addDate = isPrev ? -1 : 1;

        if(slctType == 0) {
            dayButtonPrev(addDate);
        }else if(slctType == 1) {
            monthButtonPrev(addDate);
        }else if(slctType == 3) {
            dateRangePrev(addDate);
        }

    }

    function setSummary(response){

        console.log("-------------- setSummary -----------------");
        console.log(response);

        response.totalInfo.accum_total_join_cnt = accum_total_join_cnt;
        response.totalInfo.accum_total_out_cnt = accum_total_out_cnt;
        response.totalInfo.accum_total_join_before_cnt = accum_total_join_before_cnt;
        response.totalInfo.accum_total_out_before_cnt = accum_total_out_before_cnt;

        response.totalInfo.sum_inc_total_cnt = response.totalInfo.sum_total_join_cnt - response.totalInfo.accum_total_join_before_cnt;

        response.totalInfo.sum_total_out_cnt = response.totalInfo.sum_pc_total_out_cnt + response.totalInfo.sum_aos_total_out_cnt + response.totalInfo.sum_ios_total_out_cnt;
        response.totalInfo2.sum_total_out_cnt = response.totalInfo2.sum_pc_total_out_cnt + response.totalInfo2.sum_aos_total_out_cnt + response.totalInfo2.sum_ios_total_out_cnt;

        response.totalInfo.sum_inc_out_total_cnt = response.totalInfo.sum_total_out_cnt - response.totalInfo.accum_total_out_before_cnt;

        var template = $('#tmp_summary').html();
        var templateScript = Handlebars.compile(template);
        var context = response.totalInfo;
        var html=templateScript(context);
        $("#summary").html(html);

        ui.tableHeightSet();
        ui.paintColor();
    }

    function withdrawalListSummary(json){
        var template = $("#joinList_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.summary
            , length : json.recordsTotal
        }
        var html = templateScript(data);
        $("#joinList_summaryArea").html(html);

        ui.tableHeightSet();
        ui.paintColor();
    }
</script>


<script type="text/x-handlebars-template" id="tmp_summary">
    <table class="table table-bordered _tableHeight no-margin" data-height="23px">
        <colgroup>
            <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
            <col width="8.3%"/><col width="8.3%"/><col width="10%"/><col width="10%"/>
        </colgroup>

        <tr>
            <th colspan="3" class="_bgColor" data-bgColor="#b3c7e7">성별</th>
            <th colspan="3" class="_bgColor" data-bgColor="#f8cbaa">플랫폼별</th>
            <th colspan="2" class="_bgColor" data-bgColor="#bfbfbf">총합</th>
            <th class="_bgColor" data-bgColor="#bfbfbf">비율</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgColor="#dbe2f4">{{{sexIcon 'm'}}}</th>
            <th class="_bgColor" data-bgColor="#dbe2f4">{{{sexIcon 'f'}}}</th>
            <th class="_bgColor" data-bgColor="#dbe2f4">{{{sexIcon 'n'}}}</th>
            <th class="_bgColor" data-bgColor="#fde6d8">AOS</th>
            <th class="_bgColor" data-bgColor="#fde6d8">IOS</th>
            <th class="_bgColor" data-bgColor="#fde6d8">PC</th>
            <th class="_bgColor" data-bgColor="#ffe699">가입</th>
            <th class="_bgColor" data-bgColor="#f2f2f2">탈퇴</th>
            <th class="_bgColor" data-bgColor="#f2f2f2">가입 대비 탈퇴</th>
        </tr>
        <tr>
            <td>{{sum_total_out_mcnt}}<br/>({{average  sum_total_out_mcnt sum_total_out_cnt}}%)</td>
            <td>{{sum_total_out_fcnt}}<br/>({{average  sum_total_out_fcnt sum_total_out_cnt}}%)</td>
            <td>{{sum_total_out_ncnt}}<br/>({{average  sum_total_out_ncnt sum_total_out_cnt}}%)</td>
            <td>{{sum_aos_total_out_cnt}}<br/>({{average  sum_aos_total_out_cnt sum_total_out_cnt}}%)</td>
            <td>{{sum_ios_total_out_cnt}}<br/>({{average  sum_ios_total_out_cnt sum_total_out_cnt}}%)</td>
            <td>{{sum_pc_total_out_cnt}}<br/>({{average sum_pc_total_out_cnt sum_total_out_cnt}}%)</td>
            <td class="{{upAndDownClass sum_inc_total_cnt}}"><span style="color: #555555">{{sum_total_join_cnt}}</span> <br/> (<i class="fa {{upAndDownIcon sum_inc_total_cnt}}"></i> <span>{{addComma sum_inc_total_cnt}}</span>)</td>
            <td class="{{upAndDownClass sum_inc_out_total_cnt}}"><span style="color: #555555">{{sum_total_out_cnt}}</span> <br/> (<i class="fa {{upAndDownIcon sum_inc_out_total_cnt}}"></i> <span>{{addComma sum_inc_out_total_cnt}}</span>)</td>
            <td>{{average sum_total_out_cnt sum_total_join_cnt 0}}%</td>
        </tr>

    </table>
</script>



<script id="joinList_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered _tableHeight no-margin" data-height="23px">
        <colgroup>
            <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
            <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
        </colgroup>

        <colgroup>
            <col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/><col width="8.3%"/>
            <col width="8.3%"/><col width="8.3%"/><col width="10%"/><col width="10%"/>
        </colgroup>

        <tr>
            <th colspan="3" class="_bgColor" data-bgColor="#b3c7e7">성별</th>
            <th colspan="3" class="_bgColor" data-bgColor="#f8cbaa">플랫폼별</th>
            <th class="_bgColor" data-bgColor="#bfbfbf">총합</th>
        </tr>
        <tr>
            <th class="_bgColor" data-bgColor="#dbe2f4">{{{sexIcon 'm'}}}</th>
            <th class="_bgColor" data-bgColor="#dbe2f4">{{{sexIcon 'f'}}}</th>
            <th class="_bgColor" data-bgColor="#dbe2f4">{{{sexIcon 'n'}}}</th>
            <th class="_bgColor" data-bgColor="#fde6d8">AOS</th>
            <th class="_bgColor" data-bgColor="#fde6d8">IOS</th>
            <th class="_bgColor" data-bgColor="#fde6d8">PC</th>
            <th class="_bgColor" data-bgColor="#f2f2f2">탈퇴</th>
        </tr>
        <tr>
            <td>{{content.maleCnt}}<br/>({{average content.maleCnt content.allCnt}}%)</td>
            <td>{{content.femaleCnt}}<br/>({{average content.femaleCnt content.allCnt}}%)</td>
            <td>{{content.noneCnt}}<br/>({{average content.noneCnt content.allCnt}}%)</td>
            <td>{{content.aosCnt}}<br/>({{average content.aosCnt content.allCnt}}%)</td>
            <td>{{content.iosCnt}}<br/>({{average content.iosCnt content.allCnt}}%)</td>
            <td>{{content.pcCnt}}<br/>({{average content.pcCnt content.allCnt}}%)</td>
            <td>{{content.allCnt}}</td>
        </tr>
    </table>
</script>