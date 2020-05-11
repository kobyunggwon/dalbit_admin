<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>

<div id="wrapper">
    <form id="targetForm"></form>
</div>




<script src="../../../js/lib/jquery.table2excel.js"></script>

<script>
    $(document).ready(function () {
        fnc_messageDetail.init();
    });


    var fnc_messageDetail = {
//=------------------------------ Init / Event / UI--------------------------------------------
        "targetId": "messageDetail",
        "formId" : "messageDetailForm",

        init() {
            this.target = $("#"+this.targetId);
            this.target.find("#targetForm").attr("id", this.targetId + "Form");
            this.formId = this.targetId + "Form";

            if(common.isEmpty(getSelectDataInfo())){
                fnc_messageDetail.insertDetail();
            }else{
                var data = new Object();
                data.message_idx = getSelectDataInfo().data.message_idx;

                util.getAjaxData(fnc_messageDetail.targetId, "/rest/content/message/detail",data, fnc_messageDetail.fn_detail_success, fnc_messageDetail.fn_fail);
            }

            // this.initDetail();
            // this.initDetailEvent();
        },


        // 초기 설정
        initDetail() {
            // 캘린더
            this.target.find('.input-group.date').datetimepicker({
                format: 'L'
                , date: new Date()
            });

            // 시간 Select CSS 적용
            this.target.find("#timeHour").attr("class", "select-time");
            this.target.find("#timeMinute").attr("class", "select-time");
        },

        // 이벤트 적용
        initDetailEvent()
        {

            //수신대상 선택
            this.target.find("input[name='is_all']").change(function () {
                if ($(this).val() == "7") { //지정 회원
                    fnc_messageDetail.target.find("#btn_selectMember").prop("disabled", false);
                    fnc_messageDetail.target.find("#div_selectTarget").show();
                } else {
                    fnc_messageDetail.target.find("#btn_selectMember").prop("disabled", true);
                    fnc_messageDetail.target.find("#div_selectTarget").hide();
                    fnc_messageDetail.target.find("#div_selectTarget").empty();
                }
            });


            //OS 구분
            this.target.find("input[name='platform']").change(function () {
                if ($(this).val() == "-1") {
                    if ($(this).is(":checked")) {
                        fnc_messageDetail.target.find("input[name='platform']").each(function () {
                            this.checked = true;
                        });
                    } else {
                        fnc_messageDetail.target.find("input[name='platform']").each(function () {
                            this.checked = false;
                        });
                    }
                } else {
                    if ($(this).is(":checked")) {
                        var cntTotal = fnc_messageDetail.target.find("input[name='platform']").length;
                        var cntChecked = fnc_messageDetail.target.find("input[name='platform']:checked").length;
                        if ((cntTotal) == (cntChecked + 1)) {
                            fnc_messageDetail.target.find("input[name='platform'][value='-1']").prop("checked", true);
                        }
                    } else {
                        fnc_messageDetail.target.find("input[name='platform'][value='-1']").prop("checked", false);
                    }
                }
            });


            //발송여부 선택
            this.target.find("input[name='is_direct']:radio").change(function () {
                var type = this.value;

                //예약 발송 일 경우 날짜 추가
                if (type == "1") {
                    fnc_messageDetail.target.find("#message-div-sendDate").show();
                } else {
                    fnc_messageDetail.target.find("#message-div-sendDate").hide();
                }
            });

            // 지정회원 - 수신대상
            this.target.find("#btn_selectMember").on("click", function () {
                showPopMemberList(fnc_messageDetail.choiceMember);
            })


            // 등록 버튼
            this.target.find("#insertBtn").on("click", function () {
                if(!confirm("등록 하시겠습니까?")){
                    return false;
                }

                var data = fnc_messageDetail.getDetailData();

                if(!fnc_messageDetail.isValid(data)){
                    return false;
                }

                util.getAjaxData("insert", "/rest/content/message/insert", data, fnc_messageDetail.fn_insert_success, fnc_messageDetail.fn_fail);
            })


            // 수정 버튼
            this.target.find("#updateBtn").on("click", function () {
                if(!confirm("재발송 하시겠습니까?")){
                    return false;
                }

                var data = fnc_messageDetail.getDetailData();

                if(!fnc_messageDetail.isValid(data)){
                    return false;
                }

                util.getAjaxData("upldate", "/rest/content/message/insert", data, fnc_messageDetail.fn_update_success, fnc_messageDetail.fn_fail);
            })
        },


        //수정 데이터 조회 후 UI 처리
        initUpdateUI(){
            var detailData = getSelectDataInfo().detailData;
            console.log(detailData);

        },


        // 등록 화면
        insertDetail() {
            var template = $('#tmp_messageDetailFrm').html();
            var templateScript = Handlebars.compile(template);
            this.target.find("#"+this.formId).html(templateScript);

            this.initDetail();
            this.initDetailEvent();
        },

        // 수정 화면
        updateDetail(){
            var detailData = getSelectDataInfo().detailData;
            detailData.rowNum = getSelectDataInfo().data.rowNum;
            dalbitLog(detailData);


            // form 띄우기
            var template = $('#tmp_messageDetailFrm').html();
            var templateScript = Handlebars.compile(template);
            var context = detailData;
            var html = templateScript(context);
            fnc_messageDetail.target.find("#"+ fnc_messageDetail.formId).html(html);

            fnc_messageDetail.initDetail();
            fnc_messageDetail.initDetailEvent();
            fnc_messageDetail.initUpdateUI();
        },

//=------------------------------ Option --------------------------------------------

        // 상세 목록 조회 성공 시
        fn_detail_success(dst_id, data, dst_params){
            if(data.result == "fail"){
                alert(data.message);
                return false;
            }

            setSelectDataInfo("detailData", data.data);

            fnc_messageDetail.updateDetail();
        },


        // 등록 성공 시
        fn_insert_success(dst_id, data, dst_params){
            if(data.result == "fail"){
                alert(data.message);
                return false;
            }

            alert(data.message);
            // alert(data.message +'\n- 성공 : ' + data.data.sucCnt + '건\n- 실패 : ' + data.data.failCnt +'건');

            fnc_messageList.selectMainList(false);

            //하위 탭 초기화
            initContentTab();
            //상단 이동
            $('html').animate({scrollTop : 0}, 100);
            $("#"+fnc_messageDetail.formId).empty();
        },


        // 수정 성공 시
        fn_update_success(dst_id, data, dst_params){
            if(data.result == "fail"){
                alert(data.message);
                return false;
            }

            alert(data.message);
            // alert(data.message +'\n- 성공 : ' + data.data.sucCnt + '건\n- 실패 : ' + data.data.failCnt +'건');

            fnc_messageList.selectMainList(false);

            //하위 탭 초기화
            initContentTab();
            //상단 이동
            $('html').animate({scrollTop : 0}, 100);
            $("#"+fnc_messageDetail.formId).empty();
        },


        // Ajax 실패
        fn_fail(data, textStatus, jqXHR){
            alert(data.message);

            console.log(data, textStatus, jqXHR);
        },

//=------------------------------ Data Handler ----------------------------------

        // 데이터 가져오기
        getDetailData(){
            var resultJson ={};

            var formArray = this.target.find("#" + this.formId).serializeArray();
            for (var i = 0; i < formArray.length; i++){
                resultJson[formArray[i]['name']] = formArray[i]['value'];
            }

            dalbitLog(resultJson)
            return resultJson;
        },


        isValid(data) {

            if (common.isEmpty(data.send_cont)) {
                alert("메시지 내용을 입력하여 주시기 바랍니다.");
                fnc_messageDetail.target.find("input[name=send_cont]").focus();
                return false;
            }

            return true;
        },


//=------------------------------ Modal ----------------------------------

    }
</script>






<!-- =------------------ Handlebars ---------------------------------- -->

<script id="tmp_messageDetailFrm" type="text/x-handlebars-template">
    <input type="hidden" name="message_idx" value="{{message_idx}}" />
    <div class="row col-lg-12">
        <div class="row col-md-12" style="padding-bottom: 15px">
            <div class="pull-left">
                ㆍ 재발송 버튼으로 동일한 내용이나 수정한 내용으로 발송이 가능합니다.
            </div>
            <div class="pull-right">
                {{^message_idx}}<button class="btn btn-default" type="button" id="insertBtn">발송</button>{{/message_idx}}
                {{#message_idx}}<button class="btn btn-default" type="button" id="updateBtn">재발송</button>{{/message_idx}}
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
            <tr>
                <th>메세지 내용</th>
                <td colspan="9">
                    <div>
                        <textarea class="form-control" name="send_cont" id="message-send_cont" rows="8" cols="30" placeholder="전체 방송방에 전달할 메세지 내용을 작성해주세요." style="resize: none" maxlength="200">{{send_cont}}</textarea>
                        <span style="color: red">* 메시지 내용은 200자(한글) 입력 가능합니다.</span>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</script>