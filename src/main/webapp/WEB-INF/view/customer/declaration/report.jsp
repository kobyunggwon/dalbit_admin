<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication var="principal" property="principal" />

<div id="wrapper">
    <div id="page-wrapper">
        <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist">
            <li class="active"><a href="#reportDetail" role="tab" data-toggle="tab">신고처리</a></li>
        </ul>
        <div class="col-lg-12 no-padding">
            <label id="report_title"></label>
        </div>

        <input type="hidden" name="reportIdx" value="{{reportIdx}}" />
        <table class="table table-bordered table-dalbit">
            <colgroup>
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="6%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
                <col width="5%" />
            </colgroup>
            <tbody>
            <tr class="align-middle">
                <th rowspan="2">No</th>
                <td rowspan="2">{{reportIdx}}</td>

                <th>신고사유</th>
                <td>{{{getCommonCodeSelect report_reason 'declaration_reason'}}}</td>

                <th>Browser</th>
                <td>{{browser}}</td>

                <th rowspan="2">접수일시</th>
                <td rowspan="2">{{reg_date}}</td>

                <th rowspan="2">처리일시</th>
                <td rowspan="2">
                    {{op_date}}
                    {{#equal op_date ''}}-{{/equal}}
                </td>

                <th>처리상태</th>
                <%--<td>{{{getCommonCodeSelect status 'declaration_status'}}}</td>--%>
                {{^equal status '0'}}<td>처리완료</td>{{/equal}}
                {{#equal status '0'}}<td>미처리</td>{{/equal}}
            </tr>
            <tr>
                <th>플랫폼</th>
                <td>{{platform}}</td>

                <th>IP Address</th>
                <td>{{ipAddress}}</td>

                <th>처리자명</th>
                <td>
                    {{op_name}}
                    {{#equal op_name ''}}-{{/equal}}
                </td>
            </tr>
            <tr class="align-middle">
                <th rowspan="1" colspan="4">신고자</th>
                <th rowspan="1" colspan="4">대상자</th>

                <th rowspan="2">제재 조치</th>
                <td rowspan="2" colspan="3">
                    {{{getCommonCodeRadio op_code 'declaration_slctType' 'Y' 'opCode'}}}
                </td>
            </tr>
            <tr>
                <td>{{mem_id}}</td>
                <td>레벨 : {{level}}<br />등급 : {{grade}}</td>
                <td>{{mem_nick}}</td>
                <td>{{memSex}}</td>

                <td>{{reported_mem_id}}</td>
                <td>레벨 : {{reported_level}}<br />등급 : {{reported_grade}}</td>
                <td>{{reported_mem_nick}}</td>
                <td>{{reported_memSex}}</td>
            </tr>
            <tr>
                <th colspan="2">누적 결제 수<br />/금액</th>
                <td colspan="2">{{addComma payCount}}개 <br />{{addComma payAmount}}원</td>

                <th colspan="2">누적 결제 수<br />/금액</th>
                <td colspan="2">{{addComma reported_payCount}}개 <br />{{addComma reported_payAmount}}원</td>

                <th rowspan="2">조치 선택</th>
                <td rowspan="2" colspan="3" id="message">
                    {{{getCommonCodeCheck message 'declaration_Message'}}}
                </td>
            </tr>
            <tr>
                <th colspan="2">누적 선물 수<br />/금액</th>
                <td colspan="2">{{addComma giftCount}}개 <br />{{addComma giftAmount}}원</td>

                <th colspan="2">누적 선물 수<br />/금액</th>
                <td colspan="2">{{addComma reported_giftCount}}개 <br />{{addComma reported_giftAmount}}원</td>
            </tr>
            <tr>
                <th colspan="2">총 신고</th>
                <td colspan="2">프로시저에 없음</td>

                <th colspan="2">총 신고/조치</th>
                <td colspan="2"> 프로시저에 없음<br />/프로시저에 없음</td>

                <th>알림 보내기</th>
                <td colspan="3">{{{getCommonCodeRadio 0 'declaration_send'}}}</td>
            </tr>
            </tbody>
        </table>

        <%-- 에디터 --%>
        <div class="widget">
            <div class="widget-header">
                <h3><i class="fa fa-user"></i> 신고 시 조치내용 </h3>
            </div>
            <div class="widget-content no-padding">
                <div class="_editor" id="chatEditor" name="charEditor">{{replaceHtml message}}</div>
            </div>
        </div>

        <!-- 채팅 내역 -->
        <div class="col-md-12 no-padding" id="chatLeft">
            <table class="table table-bordered" style="margin-bottom: -7px">
                <th>신고 시 캡쳐내용(5분)</th>
            </table>
            <table id="list_chat_detail" class="table table-sorting table-hover table-bordered datatable">
                <thead></thead>
                <tbody></tbody>
            </table>
        </div>
        <div class="col-md-6 no-padding" id="chatRight">
            <table class="table table-bordered" style="margin-bottom: -7px">
                <th id="chatRight_title"></th>
            </table>
            <table id="list_target_chat" class="table table-sorting table-hover table-bordered datatable">
                <thead></thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
</div>


<!-- 조치선택 팝업메시지 Modal -->
<div class="modal fade" id="entryModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog" style="width: 600px;display: table;">
        <div class="modal-content">
            <div class="modal-header">
                <lable>운영자에 의한 변경 사유를 선택하여 주세요</lable>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <span id="declaration_Message"></span>
                <input type="text" id="text_message" class="form-control"/>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="bt_modalEntry"><i class="fa fa-times-circle"></i> 확인</button>
                <button type="button" class="btn btn-custom-primary" id="bt_modalEntryNotice"><i class="fa fa-check-circle"></i> 확인+메시지 발송</button>
            </div>
        </div>
    </div>
</div>
<!-- Modal 끝 -->

<script type="text/javascript" src="/js/message/customer/declarationMessage.js"></script>
<script type="text/javascript">

    var dtList_info_detail;
    var dtList_info_detail_data = function (data) {
        // data.mem_no = detailData.mem_no;
        data.room_no = "91585286445106";
    }
    dtList_info_detail = new DalbitDataTable($("#list_chat_detail"), dtList_info_detail_data, BroadcastDataTableSource.chatDetail);
    dtList_info_detail.useCheckBox(false);
    dtList_info_detail.useIndex(false);
    dtList_info_detail.useOrdering(false);
    dtList_info_detail.setPageLength(20);
    dtList_info_detail.createDataTable();
    dtList_info_detail.reload();
    $("#chatLeft").removeClass("col-md-6");
    $("#chatLeft").addClass("col-md-12");
    $("#chatRight").addClass("hide");

    $('#bt_declaration').on('click', function(){
        if(confirm('처리하시겠습니까?')) {
            util.getAjaxData("declaration", "/rest/customer/declaration/operate", $("#declarationForm").serialize(), fn_declaration_success);
        }
    });

    function fn_declaration_success(dst_id, response) {

        dalbitLog(response);
        alert(response.message);

        dtList_info.reload();

        // 상단이동
        $('html').animate({scrollTop: 0}, 100);
        $("#declarationForm").empty();
    }

    //TODO - 이거는 나중에 처리... 처음 로드 했을 때 제재조치에 따라서 disable 시키는 기능.
    /*$(document).ready(function() {
        alert('ssss');
        $('input:radio[name="opCode"]:checked').click();
    });*/


    $(document).on('click', 'input:radio[name="opCode"]', function(title, content){
        messageCheck();
    });

    $(document).on('click', 'input:checkbox[name="declaration_Message"]',function(title, content) {
        messageCheck();
    });

    function messageCheck() {
        var msgValue = '';

        var radioValue = $('input:radio[name="opCode"]:checked').val();
        declarationCheck();

        if(radioValue == 6 || radioValue == 7){
            msgValue = declarationMessage.out;
        } else if(radioValue == 3 || radioValue == 4 || radioValue ==5){
            msgValue = declarationMessage.stop;
        } else if(radioValue == 2) {
            msgValue = declarationMessage.warning;
        } else {
            msgValue = "";
        }

        var strName = ADMIN_NICKNAME;
        var date = new Date();
        var timestamp = date.getFullYear() + "." +
            common.lpad(date.getMonth(),2,"0") + "." +
            common.lpad(date.getDay(),2,"0")
            // + " " +
            // common.lpad(date.getHours(),2,"0") + "." +
            // common.lpad(date.getMinutes(),2,"0") + "." +
            // common.lpad(date.getSeconds(),2,"0");


        // 조치선택 체크박스 클릭할 때 마다 {{message}} 여기에다가 <br />붙여서 replace..
        var msg = '';
        $('input:checkbox[name="declaration_Message"]:checked').each(function() {
            msg += $(this).val() + '<br />';
        });

        msgValue = msgValue.replace(/{{name}}/gi, strName)
            .replace(/{{nickName}}/gi, detailData.reported_mem_nick)
            .replace(/{{message}}/gi, msg)
            .replace(/{{timestamp}}/gi, timestamp);
        dalbitLog(msgValue);

        // dalbitLog('그 다음.. 에디터에 값 넣기');
        $("#chatEditor").summernote('code', msgValue);
    }

    declarationCheck();
    function declarationCheck(){
        var opCode = $('input:radio[name="opCode"]');
        var declarationValue = $('input:checkbox[name="declaration_Message"], select[name="slctReason"], input:radio[name="sendNoti"]');
        var radioValue = $('input:radio[name="opCode"]:checked').val();

        dalbitLog("length : " + $("#bt_declaration").length);
        dalbitLog("radioValue : " + radioValue);

        //라디오를 먼저 처리하고...
        //미처리 일 때는 다 해야함
        if(0 < $("#bt_declaration").length){
            opCode.removeAttr("disabled");
        }else{
            opCode.attr("disabled", "disabled");
        }

        // 메시지랑 신고사유랑 처리하자..
        if($('input:radio[name="opCode"]').prop('disabled')) {
            declarationValue.attr("disabled", "disabled");
        } else {
            declarationValue.removeAttr("disabled");
        }
    }

    var message = $('input:checkbox[name="message"]:checked').val();
    $('input:radio[name="sendNoti"]').on('click', function() {
        alert("클릭");
    })


    function targetChat(index){
        $("#chatRight").removeClass("hide");
        var metaData = dtList_info_detail.getDataRow(index);
        $("#chatLeft").removeClass("col-md-12");
        $("#chatLeft").addClass("col-md-6");
        $('#chatRight_title').html(util.memNoLink(metaData.nickname, metaData.mem_no)  + "님의 채팅글");
        var dtList_info_detail_data = function (data) {
            data.room_no = "91585286445106";
            data.mem_no = "11584402943774";
        }
        var dblist_chat_detail;
        dblist_chat_detail = new DalbitDataTable($("#list_target_chat"), dtList_info_detail_data, BroadcastDataTableSource.targetchat);
        dblist_chat_detail.useCheckBox(false);
        dblist_chat_detail.useIndex(false);
        dblist_chat_detail.useOrdering(false);
        dblist_chat_detail.setPageLength(20);
        dblist_chat_detail.createDataTable();
        dblist_chat_detail.reload();
    }
</script>