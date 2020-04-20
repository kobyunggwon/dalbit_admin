<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <form id="searchForm">
                <div class="row col-lg-12 form-inline">
                    <div class="widget widget-table searchBoxArea">
                        <div class="widget-header searchBoxRow">
                            <h3 class="title"><i class="fa fa-search"></i> 검색조건</h3>
                            <div>
                                <span id="slctTypeArea"></span>

                                <div class="input-group date" id="oneDayDatePicker">
                                    <label for="onedayDate" class="input-group-addon">
                                        <span><i class="fa fa-calendar" id="onedayDateBtn"></i></span>
                                    </label>
                                    <input type="text" class="form-control" id="onedayDate" name="onedayDate">
                                </div>

                                <div class="input-group date" id="rangeDatepicker" style="display:none;">
                                    <label for="displayDate" class="input-group-addon">
                                        <span><i class="fa fa-calendar"></i></span>
                                    </label>
                                    <input type="text" name="displayDate" id="displayDate" class="form-control" />
                                </div>

                                <input type="hidden" name="startDate" id="startDate">
                                <input type="hidden" name="endDate" id="endDate" />

                                <button type="button" class="btn btn-success" id="bt_search">검색</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>

            <div class="row col-lg-12 form-inline">
                <div class="col-lg-6 pl0 pr5">
                    <!-- 가입자수 -->
                    <div class="widget widget-table mb10">
                        <div class="widget-header">
                            <h3><i class="fa fa-table"></i> 가입자수 통계 현황</h3>
                            <div class="btn-group widget-header-toolbar">
                                <a href="#" title="Expand/Collapse" class="btn-borderless btn-toggle-expand"><i class="fa fa-chevron-up"></i></a>
                            </div>
                        </div>
                        <div class="widget-content mt10">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>가입자수</th>
                                        <th>실시간</th>
                                        <th>전일</th>
                                        <th>증감</th>
                                        <th>주간</th>
                                        <th>증감</th>
                                    </tr>
                                    </thead>
                                    <tbody id="statJoinTableBody"></tbody>
                            </table>
                        </div>
                    </div>
                    <!-- //가입자수 -->
                </div>

                <div class="col-lg-6 pr0 pl5">
                    <!-- 탈퇴자수 -->
                    <div class="widget widget-table mb10">
                        <div class="widget-header">
                            <h3><i class="fa fa-table"></i> 탈퇴자수 통계 현황</h3>
                            <div class="btn-group widget-header-toolbar">
                                <a href="#" title="Expand/Collapse" class="btn-borderless btn-toggle-expand"><i class="fa fa-chevron-up"></i></a>
                            </div>
                        </div>
                        <div class="widget-content mt10">
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th>탈퇴자수</th>
                                    <th>실시간</th>
                                    <th>전일</th>
                                    <th>증감</th>
                                    <th>주간</th>
                                    <th>증감</th>
                                </tr>
                                </thead>
                                <tbody id="statWithdrawTableBody"></tbody>
                            </table>
                        </div>
                    </div>
                    <!-- //탈퇴자수 -->
                </div>
            </div>

            <!-- tab -->
            <div class="no-padding" id="infoTab">
                <jsp:include page="infoTab.jsp"/>
            </div>
            <!-- //tab -->
        </div>
    </div>
</div>

<script type="text/javascript" src="/js/code/enter/joinCodeList.js"></script>
<script type="text/javascript">
    $(function(){
        $("#slctTypeArea").append(util.getCommonCodeRadio(0, join_slctType));

        $('#onedayDate').datepicker("onedayDate", new Date()).on('changeDate', function(dateText, inst){
            var selectDate = moment(dateText.date).format("YYYY.MM.DD");
            $("#displayDate").val(selectDate+ ' - ' + selectDate);
            $("#startDate").val(selectDate);
            $("#endDate").val(selectDate);
        });

        $("#displayDate").daterangepicker( dataPickerSrc,
            function(start, end, t1) {
                $("#startDate").val(start.format('YYYY.MM.DD'));
                $("#endDate").val(end.format('YYYY.MM.DD'));

                $("#onedayDate").val($("#startDate").val());
            }
        );

        var dateTime = new Date();
        dateTime = moment(dateTime).format("YYYY.MM.DD");
        $("#onedayDate").val(dateTime);
        $("#startDate").val(dateTime);
        $("#endDate").val(dateTime);

        //가입자수 통계 현황
        getStatJoinInfo();

        //탈퇴자수 통계 현황
        getStatWithdrawInfo();
    });

    $(document).on('change', 'input[name="slctType"]', function(){
       var me = $(this);
       if(me.val() == 0){
            $("#oneDayDatePicker").show();
            $("#rangeDatepicker").hide();

            $("#startDate").val($("#onedayDate").val());
            $("#endDate").val($("#onedayDate").val());


       }else{
           $("#oneDayDatePicker").hide();
           $("#rangeDatepicker").show();

           var rangeDate = $("#displayDate").val().split(' - ')
           if(-1 < rangeDate.indexOf(' - ')){
               $("#startDate").val(rangeDate[0]);
               $("#endDate").val(rangeDate[1]);
           };
       }
    });

    var dataPickerSrc = {
        startDate: moment(),
        endDate: moment(),
        dateLimit: { days: 365 },
        showDropdowns: true,
        showWeekNumbers: true,
        timePicker: false,
        timePickerIncrement: 1,
        timePicker12Hour: false,
        ranges: {
            '오늘': [moment(), moment()],
            '어제': [moment().subtract('days', 1), moment().subtract('days', 1)],
            '지난주': [moment().subtract('days', 6), moment()],
            '전월': [moment().subtract('days', 29), moment()]
        },
        opens: 'left',
        // buttonClasses: ['btn btn-default'],
        // applyClass: 'btn-small btn-primary',
        // cancelClass: 'btn-small',
        format: 'L',
        separator: ' to ',
        locale: {
            customRangeLabel: '직접선택',
        }
    }

    function getStatJoinInfo(){
        util.getAjaxData("statJoin", "/rest/enter/join/stat/join", null, fn_statJoin_success);
    }

    function fn_statJoin_success(data, response){
        var template = $('#tmp_statJoin').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.joinInfo;
        var html=templateScript(context);
        $("#statJoinTableBody").append(html);
    }

    function getStatWithdrawInfo(){
        util.getAjaxData("statJoin", "/rest/enter/join/stat/withdraw", null, fn_statWithdraw_success);
    }

    function fn_statWithdraw_success(data, response){
        var template = $('#tmp_statJoin').html();
        var templateScript = Handlebars.compile(template);
        var context = response.data.withdrawInfo;
        var html=templateScript(context);
        $("#statWithdrawTableBody").append(html);
    }
</script>

<script type="text/x-handlebars-template" id="tmp_statJoin">
    <tr>
        <th>남</th>
        <td>{{addComma m_now_Cnt}}</td>
        <td>{{addComma m_yes_Cnt}}</td>
        <td class="{{upAndDownClass m_now_inc_cnt}}"><i class="fa {{upAndDownIcon m_now_inc_cnt}}"></i> {{addComma m_now_inc_cnt}}</td>
        <td>{{addComma m_week_cnt}}</td>
        <td class="{{upAndDownClass m_week_inc_cnt}}"><i class="fa {{upAndDownIcon m_week_inc_cnt}}"></i> {{addComma m_week_inc_cnt}}</td>
    </tr>
    <tr>
        <th>여</th>
        <td>{{addComma f_now_Cnt}}</td>
        <td>{{addComma f_yes_Cnt}}</td>
        <td class="{{upAndDownClass f_now_inc_cnt}}"><i class="fa {{upAndDownIcon f_now_inc_cnt}}"></i> {{addComma f_now_inc_cnt}}</td>
        <td>{{addComma f_week_cnt}}</td>
        <td class="{{upAndDownClass f_week_inc_cnt}}"><i class="fa {{upAndDownIcon f_week_inc_cnt}}"></i> {{addComma f_week_inc_cnt}}</td>
    </tr>
    <tr>
        <th>알수없음</th>
        <td>{{addComma n_now_Cnt}}</td>
        <td>{{addComma n_yes_Cnt}}</td>
        <td class="{{upAndDownClass n_now_inc_cnt}}"><i class="fa {{upAndDownIcon n_now_inc_cnt}}"></i> {{addComma n_now_inc_cnt}}</td>
        <td>{{addComma n_week_cnt}}</td>
        <td class="{{upAndDownClass n_week_inc_cnt}}"><i class="fa {{upAndDownIcon n_week_inc_cnt}}"></i> {{addComma n_week_inc_cnt}}</td>
    </tr>
    <tr>
        <th>총계</th>
        <td>{{addComma t_now_Cnt}}</td>
        <td>{{addComma t_yes_Cnt}}</td>
        <td class="{{upAndDownClass t_now_inc_cnt}}"><i class="fa {{upAndDownIcon t_now_inc_cnt}}"></i> {{addComma t_now_inc_cnt}}</td>
        <td>{{addComma t_week_cnt}}</td>
        <td class="{{upAndDownClass t_week_inc_cnt}}"><i class="fa {{upAndDownIcon t_week_inc_cnt}}"></i> {{addComma t_week_inc_cnt}}</td>
    </tr>
</script>