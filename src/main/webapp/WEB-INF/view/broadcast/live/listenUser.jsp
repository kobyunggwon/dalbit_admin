<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<!-- 현재 접속자 > 현재 접속 회원 -->
<div class="widget-table mb10">
    <div class="col-md-12 no-padding">
        <div class="col-md-2 no-padding">
            <span name="listenUserType" id="listenUserType" onchange="listenUserType_sel_change()"></span>
        </div>
        <div class="col-md-4 no-padding pull-right">
            <span id="live_summaryArea2"></span>
        </div>
        <div class="col-md-3 no-padding pull-right">
            <span id="liveListener_summaryArea"></span>
        </div>
        <div class="col-md-12 no-padding pull-right mt5">
            <div class="col-md-2 no-padding pull-right">
                <table class="table table-sorting table-hover table-bordered">
                    <colgroup>
                        <col width="15%"/><col width="65%"/>
                    </colgroup>
                    <tr>
                        <td style="background-color: #dae3f3"></td><td>테스트 아이디</td>
                    </tr>
                </table>
            </div>
        </div>
        <table id="listenUser_tableList" class="table table-sorting table-hover table-bordered datatable">
            <thead id="tableTop_detail">
            </thead>
            <tbody id="tableBody_detail">
            </tbody>
        </table>
    </div>
    </span>
    <div class="widget-footer">
        <span>
            <%--<button class="btn btn-default print-btn pull-right" type="button" id="excelDownBtn"><i class="fa fa-print"></i>Excel Down</button>--%>
        </span>
    </div>
</div>

<script type="text/javascript" src="/js/code/broadcast/broadCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    $("#listenUserType").html(util.getCommonCodeSelect(0, liveListenSort));

    $(function(){
        $("#selJoinDate").hide();
        getListenUserList();

    });

    var dtList_info_lisetnUser;
    function getListenUserList(){
        var dtList_data = function (data) {
            data.pageCnt = 100;
            data.searchText = $("#txt_search").val();
            data.sortState = $("select[name='liveListenSort']").val();
            data.inner = 0;
        };
        dtList_info_lisetnUser = new DalbitDataTable($("#listenUser_tableList"), dtList_data, BroadcastDataTableSource.liveListenerList);
        dtList_info_lisetnUser.setPageLength(50);
        dtList_info_lisetnUser.useCheckBox(false);
        dtList_info_lisetnUser.useIndex(true);
        dtList_info_lisetnUser.createDataTable(liveNextFunc);
    }

    function liveNextFunc(json){
        var template = $("#liveListener_tableSummary").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : json.summary
            , length : json.recordsTotal
        };
        var html = templateScript(data);
        $("#liveListener_summaryArea").html(html);

        $("#tab_liveListener").text("실시간 청취자(" + json.recordsTotal + ")");

        var data = {};
        data.slctType = 1;
        data.dj_slctType = 0;
        data.dj_searchText = $('#txt_search').val();
        data.room_slctType = -1;
        data.room_searchText = "";
        data.ortStartDate =2;
        data.room_liveType = 1;
        data.startDate = sDate;

        util.getAjaxData("broadlive", "/rest/broadcast/broadcast/list", data, fn_success_live_summary);
    }

    function getListenUserList_tabClick(tmp){
        $("#selJoinDate").hide();
        liveState = tmp;
        dtList_info_lisetnUser.reload(liveNextFunc);
        dtList_info_loginUser.reload(loginNextFunc);
        dtList_info.changeReload(null,dtList_info_data,BroadcastDataTableSource.liveList,summary_table);
    }
    function listenUserType_sel_change(){
        $("#selJoinDate").hide();
        dtList_info_lisetnUser.reload(liveNextFunc);
        dtList_info_loginUser.reload(loginNextFunc);
        dtList_info.changeReload(null,dtList_info_data,BroadcastDataTableSource.liveList,summary_table);
    }

    function fn_success_live_summary(dst_id,response){
        var template = $("#live_tableSummary2").html();
        var templateScript = Handlebars.compile(template);
        var data = {
            content : response.summary
            , length : response.recordsTotal
        };
        var html = templateScript(data);
        $("#live_summaryArea2").html(html);
    }

    function liveListenForced(index){
        var data = dtList_info_lisetnUser.getDataRow(index);
        if(confirm(data.nickNm + "님을 강제 퇴장 하시겠습니까?")){
            var obj = {};
            obj.mem_no = data.memNo;
            obj.room_no = data.roomNo;
            obj.mem_nickName = data.nickNm;
            obj.roomBlock = "N";
            obj.NotificationYn = "N";
            obj.NotiMemo = "청취 강제 퇴장";
            obj.forced = "exit";

            util.getAjaxData("forceLeave", "/rest/broadcast/listener/forceLeave", obj, liveListenForced_success);

        }else{ return false ;}

    }

    function liveListenNotice(index){
        var data = dtList_info_lisetnUser.getDataRow(index);
        tmp = "/broadcast/live/popup/noticeSendPopup?memNo=" + encodeURIComponent(data.memNo) + "&memNick=" + encodeURIComponent(data.nickNm);
        util.windowOpen(tmp,"750","320","회원 메시지발송");
    }

    function liveListenForced_success(dst_id, response){
        dalbitLog(response);
        dtList_info_lisetnUser.reload(liveNextFunc);
    }


</script>


<script id="liveListener_tableSummary" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right no-margin" style="width: 80%">
        <tr>
            <th colspan="7" style="background-color: #2f5597;color: white">청취자</th>
        </tr>
        <tr>
            <th colspan="3" style="background-color: #d9d9d9;color: black">플랫폼</th>
            <th colspan="4" style="background-color: #d9d9d9;color: black">성별</th>
        </tr>
        <tr>
            <td style="background-color: #dae3f3" class="font-bold">Android</td>
            <td style="background-color: #dae3f3" class="font-bold">IOS</td>
            <td style="background-color: #dae3f3" class="font-bold">PC</td>
            <td style="background-color: #dae3f3">{{{sexIcon 'm'}}}</td>
            <td style="background-color: #dae3f3">{{{sexIcon 'f'}}}</td>
            <td style="background-color: #dae3f3">{{{sexIcon 'n'}}}</td>
            <th style="background-color: #dae3f3;">비회원</th>
        </tr>
        <tr>
            <td>{{addComma content.aosCnt}}</td>
            <td>{{addComma content.iosCnt}}</td>
            <td>{{addComma content.pcCnt}}</td>
            <td>{{addComma content.maleCnt}}</td>
            <td>{{addComma content.femaleCnt}}</td>
            <td>{{addComma content.noneCnt}}</td>
            <td>{{addComma content.noneMemberCnt}}</td>
        </tr>
        <tr>
            <td colspan="7" class="font-bold" style="background-color: #7f7f7f;color: white">총 수 {{addComma content.totalCnt}}</td>
        </tr>
    </table>
</script>

<script id="live_tableSummary2" type="text/x-handlebars-template">
    <table class="table table-bordered table-summary pull-right no-margin" style="width: 100%">
        <tr>
            <th colspan="8" style="background-color: #bf9000;color: white">방송방</th>
        </tr>
        <tr>
            <th colspan="3" style="background-color: #fff2cc;">플랫폼</th>
            <th colspan="2" style="background-color: #fff2cc;">DJ구분</th>
            <th colspan="3" style="background-color: #fff2cc;">DJ성별</th>
        </tr>
        <tr>
            <th style="background-color: #f2f2f2;">Android</th>
            <th style="background-color: #f2f2f2;">IOS</th>
            <th style="background-color: #f2f2f2;">PC</th>
            <th style="background-color: #fee599;">일반(스페셜DJ)</th>
            <th style="background-color: #fee599;">신입</th>
            <th style="background-color: #f2f2f2;">{{{sexIcon 'm'}}}</th>
            <th style="background-color: #f2f2f2;">{{{sexIcon 'f'}}}</th>
            <th style="background-color: #f2f2f2;">{{{sexIcon 'n'}}}</th>
        </tr>
        <tr>
            <td>{{#equal length '0'}}0{{/equal}}{{content.totalAosCnt}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.totalIosCnt}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.totalPcCnt}}</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.normalDjCnt}} ({{content.specialDjCnt}})</td>
            <td>{{#equal length '0'}}0{{/equal}}{{content.newDjCnt}}명</td>
            <td>{{content.broadMaleCnt}}</td>
            <td>{{content.broadFemaleCnt}}</td>
            <td>{{content.broadNoneCnt}}</td>
        </tr>
        <tr>
            <td class="font-bold" style="background-color: #d8d8d8;" colspan="3">총 수(방송중/끊김)</td>
            <td class="font-bold" style="background-color: #d8d8d8; color: #ed7d31" colspan="5">{{content.totalBroadCastCnt}} ({{content.broadStateNomal}}/{{content.broadBreak}})</td>
        </tr>
    </table>
</script>