<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>

<style>
   .test{
        border-color: black;
        border: 1px solid #DDDDDD;
    }

   .text_center{
       text-align: center;
   }
   .middle{
       display:table-cell;
       vertical-align:middle;
   }
   .lb_style{
       border: 1px solid #DDDDDD;
       background-color: #DCE6F2;
       height: 34px;
   }
</style>

<div id="wrapper">
    <form id="pushForm"></form>
</div>



<script src="../../../js/lib/jquery.table2excel.js"></script>

<script>
    $(document).ready(function () {
        // init_Detail();
        // initEvent_Detail();
    });


//=------------------------------ Init / Event--------------------------------------------

    // 초기 설정
    function init_Detail() {
        // 캘린더
        $('.input-group.date').datetimepicker({
            format: 'L'
            ,date: new Date()
        });

        // 시간 Select CSS 적용
        $("#timeHour").attr("class", "select-time");
        $("#timeMinute").attr("class", "select-time");
    }

    // 이벤트 적용
    function initEvent_Detail(tab_id){

        //수신대상 선택
        $("input[name='receiveType']").change(function(){
            if($(this).val() == "-1"){
                if($(this).is(":checked")){
                    $("input[name='receiveType']").each( function(){
                        if($(this).val() != "target"){
                            this.checked = true;
                        }
                    });
                }else{
                    $("input[name='receiveType']").each( function(){
                        if($(this).val() != "target"){
                            this.checked = false;
                        }
                    });
                }
            }else if($(this).val() == "target"){ //지정 회원
                if($(this).is(":checked")){
                    $("#btn_selectMember").prop("disabled",false);
                    $("#div_selectTarget").show();
                }else{
                    $("#btn_selectMember").prop("disabled",true);
                    $("#div_selectTarget").hide();
                    $("#div_selectTarget").empty();
                }
            }else{
                if($(this).is(":checked")){
                    var cntTotal = $("input[name='receiveType']").length;
                    var cntChecked = $("input[name='receiveType']:checked").length;
                    if((cntTotal - 1) == (cntChecked + 1)){     //지정회원 제외
                        $("input[name='receiveType'][value='-1']").prop("checked", true);
                    }
                }else{
                    $("input[name='receiveType'][value='-1']").prop("checked", false);
                }
            }
        });


        //OS 구분
        $("input[name='osType']").change(function(){
            if($(this).val() == "-1"){
                if($(this).is(":checked")){
                    $("input[name='osType']").each( function(){
                        this.checked = true;
                    });
                }else{
                    $("input[name='osType']").each( function(){
                        this.checked = false;
                    });
                }
            }else{
                if($(this).is(":checked")){
                    var cntTotal = $("input[name='osType']").length;
                    var cntChecked = $("input[name='osType']:checked").length;
                    if((cntTotal) == (cntChecked + 1)){
                        $("input[name='osType'][value='-1']").prop("checked", true);
                    }
                }else{
                    $("input[name='osType'][value='-1']").prop("checked", false);
                }
            }
        });



        //발송여부 선택
        $("input[name='sendType']:radio").change(function () {
            var type = this.value;

            //예약 발송 일 경우 날짜 추가
            if(type == "1"){
                $("#pushMsg-div-sendDate").show();
            }else{
                $("#pushMsg-div-sendDate").hide();
            }
        });

        // 지정회원 - 수신대상
        $("#btn_selectMember").on("click", function () {
            showPopMemberList(choiceMember);
        })







        // 등록 완료 버튼
        $("#insertBtn").on("click", function () {
            var data = getPushMsgData();

            if(!isValid(data)){
                return false;
            }

            util.getAjaxData("insert", "/rest/content/push/insert", data, fn_push_insert_success, fn_fail);
        });

        // 수정 완료 버튼
        $("#updateBtn").on("click", function () {
            //TODO 완료처리 필요
            var data = getPushMsgData();

            util.getAjaxData("insert", "/rest/content/push/update", data, fn_push_update_success, fn_fail);
        });

    }





//=------------------------------ Option --------------------------------------------

    // 등록 화면
    function insertPushMsg() {
        var template = $('#tmp_pushDetailFrm').html();
        var templateScript = Handlebars.compile(template);
        $("#pushForm").html(templateScript);

        console.log(templateScript);

        init_Detail();
        initEvent_Detail();
    }

    // 수정 화면
    function updatePushMsg(json){
        dalbitLog(json);
        // form 띄우기
        var template = $('#tmp_pushDetailFrm').html();
        var templateScript = Handlebars.compile(template);
        var context = json;
        var html = templateScript(context);
        $("#pushForm").html(html);

        init_Detail();
        initEvent_Detail();

        //TODO 데이터 셋팅 후 이벤트 처리 필요
    }


    // 등록 성공 시
    function fn_push_insert_success(dst_id, data, dst_params){
        alert(data.message);

        //상단 이동
        $('html').animate({scrollTop : 0}, 100);
        $("#pushForm").empty();
    }

    // 수정 성공 시
    function fn_push_update_success(dst_id, data, dst_params){
        alert(data.message);

        //상단 이동
        $('html').animate({scrollTop : 0}, 100);
        $("#pushForm").empty();
    }

    // Ajax 실패
    function fn_fail(data, textStatus, jqXHR){
        alert(data.message);

        console.log(data, textStatus, jqXHR);
    }


//=------------------------------ Data Handler ----------------------------------

    // 데이터 가져오기
    function getPushMsgData(){
        var resultJson ={};

        var formArray = $("#pushForm").serializeArray();
        for (var i = 0; i < formArray.length; i++){
            resultJson[formArray[i]['name']] = formArray[i]['value'];
        }

        //Date 처리이이이~~~
        var sendDateDiv = $("#pushMsg-div-sendDate");
        resultJson['sendDate'] = sendDateDiv.find("#pushMsg-sendDate").val().replace(/[^0-9]/gi, '') + sendDateDiv.find("#timeHour").val() + sendDateDiv.find("#timeMinute").val();

        //지정회원 parsing
        var selectTarget = [];
        if($("input:checkbox[name=receiveType]:checked").val() == "target"){
            $("#div_selectTarget").find("p").each(function () {
                var id = $(this).prop("id");
                selectTarget.push(id);
            })
            resultJson['mem_no'] = selectTarget.toString();
        }

        dalbitLog(resultJson)
        return resultJson;
    }



    function isValid(data){
        if(common.isEmpty(data.mem_no)){
            alert("발송 대상을 선택하여 주시기 바랍니다.")
            return false;
        }

        if(common.isEmpty(data.title)){
            alert("메시지 제목을 입력하여 주시기 바랍니다.")
            return false;
        }

        if(common.isEmpty(data.contents)){
            alert("메시지 내용을 입력하여 주시기 바랍니다.")
            return false;
        }

        return true;
    }


//=------------------------------ Modal ----------------------------------

    // [수신대상 선택 - 지정회원] 회원 추가
    function choiceMember(data){
        var html = '<p id="'+ data.mem_no +'">' + data.mem_no + ' <a onclick="delMember($(this))">[X]</a></p>'

        if($("#div_selectTarget").find("p").length >= 1){
            alert("수신대상자는 최대 1명까지 지정 가능합니다.");
            return false;
        }

        //TODO 테스트 진행중 으로 인한 주석 (2020.03.31) 위에 if로 대체
        // if($("#div_selectTarget").find("p").length >= 20){
        //     alert("수신대상자는 최대 20명까지 지정 가능합니다.");
        //     return false;
        // }

        $("#div_selectTarget").append(html);
    }

    // [수신대상 선택 - 지정회원] 회원 삭제
    function delMember(dom) {
        dom.parent("p").remove();
    }


</script>






<!-- =------------------ Handlebars ---------------------------------- -->

<script id="tmp_pushDetailFrm" type="text/x-handlebars-template">
    <input type="hidden" name="pushIdx" value="{{pushIdx}}" />
    <div class="row col-lg-12">
        <div class="row col-md-12" style="padding-bottom: 15px">
            <div class="pull-left">
                ㆍ <b>*</b> 는 필수 입력사항 입니다. <br>
                ㆍ 발송 상태를 확인하시고 미발송 또는 발송오류 시 해당 정보가 맞는지 확인한 후 수정완료를 하시면 재발송이 가능합니다.
            </div>
            <div class="pull-right">
                {{^pushIdx}}<button class="btn btn-default" type="button" id="insertBtn">등록하기</button>{{/pushIdx}}
                {{#pushIdx}}<button class="btn btn-default" type="button" id="updateBtn">수정하기</button>{{/pushIdx}}
            </div>
        </div>
        <table class="table table-bordered table-dalbit">
            <colgroup>
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
            </colgroup>
            <tbody>
            <tr class="align-middle">
                <th>No</th>
                <td>{{pushIdx}}</td>

                <th>발송상태</th>
                <td colspan="3">{{{getCommonCodeRadio 0 'push_snedStatus'}}}</td>

                <th>노출 OS구분</th>
                <%--<td colspan="5">{{{getCommonCodeRadio -1 'push_osType'}}}</td>--%>
                <td colspan="5">
                    <label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="osType" value="-1" checked="true"><span>전체</span> </label>
                    <label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="osType" value="1" checked="true"><span>PC</span></label>
                    <label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="osType" value="2" checked="true"><span>Android</span></label>
                    <label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="osType" value="3" checked="true"><span>IOS</span></label>
                </td>
            </tr>
            <tr>
                <th>메세지 제목</th>
                <td colspan="5"><input type="text" class="form-control" name="title" id="pushMsg-title" placeholder="관리를 위한 제목을 입력해주세요."></td>

                <th rowspan="2">수신대상 선택</th>
                <td colspan="5" rowspan="2">
                    <div>
                        <label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="receiveType" value="-1" disabled><span>전체</span> </label>
                        <%--<label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="receiveType" value="1" checked="true"><span>생방송</span></label>--%>
                        <%--<label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="receiveType" value="2" checked="true"><span>여자</span></label>--%>
                        <%--<label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="receiveType" value="3" checked="true"><span>남자</span></label>--%>
                        <%--<label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="receiveType" value="4" checked="true"><span>로그인</span></label>--%>
                        <%--<label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="receiveType" value="5" checked="true"><span>비로그인</span></label>--%>
                        <div>
                            <label class="control-inline fancy-checkbox custom-color-green"><input type="checkbox" name="receiveType" value="target" checked="true"><span>지정 회원 </span></label>
                            <input type="button" value="회원검색" class="btn btn-success btn-xs" id="btn_selectMember"/>
                        </div>
                    </div>
                    <div id="div_selectTarget" style="padding-left: 30px;">
                    </div>
                </td>
            </tr>
            <tr>
                <th rowspan="3">메세지 내용</th>
                <td colspan="5" rowspan="3">
                    <div>
                        <textarea class="form-control" name="contents" id="pushMsg-contents" rows="5" cols="30" placeholder="방송 시스템에 적용되는 내용을 작성해주세요." style="resize: none" maxlength="40"></textarea>
                        <span style="color: red">* 메시지 내용은 10자~40자(한글) 입력 가능합니다.</span>
                    </div>
                </td>
            </tr>
            <tr>
                <th>메세지 구분</th>
                <td colspan="5">{{{getCommonCodeRadio 1 'push_messageType'}}}</td>
            </tr>
            <tr>
                <th>발송여부</th>
                <td colspan="5">
                    <div>
                        {{{getCommonCodeRadio 0 'push_sendType'}}}
                    </div>
                    <div class="input-group date" id="pushMsg-div-sendDate" style="display:none;">
                        <span class="input-group-addon"><i class="fa fa-calendar"></i></span>
                        <input type="text" class="form-control" id="pushMsg-sendDate" style="width:100px">
                        {{{getCommonCodeSelect 00 'timeHour'}}}
                        <span> : </span>
                        {{{getCommonCodeSelect 00 'timeMinute'}}}
                    </div>
                </td>
            </tr>
            <tr>
                <!--
                <th>메세지 포함 이미지</th>
                <td colspan="5">
                    <div>
                        <input type="file" id="pushMsg-inputImg">
                        <p class="help-block"><em>Valid file type: .jpg, .png, .txt, .pdf. File size max: 1 MB</em></p>
                    </div>
                </td>
                -->
                <th>푸시 타입</th>
                <td colspan="5">{{{getCommonCodeRadio 1 'push_slctPush'}}}</td>

                <th>등록/수정일</th>
                <td colspan="5">{{date}}</td>
            </tr>
            </tbody>
        </table>
    </div>
</script>