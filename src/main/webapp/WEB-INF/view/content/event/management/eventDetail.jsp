<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="dummyData"><%= java.lang.Math.round(java.lang.Math.random() * 1000000) %></c:set>

<form id="eventInfoForm"></form>
<input type="hidden" id="prizewinner"/>

<div id="eventDetail_fullSize"></div>

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>

<script type="text/javascript">

    var dateTime = new Date();
    dateTime = moment(dateTime).format("YYYY.MM.DD");

    function initDetail_insert() {
        var template = $('#tmp_eventInfoForm').html();
        var templateScript = Handlebars.compile(template);
        $("#eventInfoForm").html(templateScript);

        // setTimeDate(dateTime);

        $('._calendar').datepicker('._calendar', new Date()).on('changeDate', function(dateText, inst) {
            var selectDate = moment(dateText.date).format('YYYY.MM.DD');
            $(this).val(selectDate);
        });
    }

    // function setTimeDate(dateTime) {
    //     $('#eventStartDate').val(dateTime);
    //     $('#eventEndDate').val(dateTime);
    //     $('#announcementDate').val(dateTime);
    // }

    function initDetail() {
        var data = {
            eventIdx : $("#eventidx").val()
        };
        util.getAjaxData("eventInfo", "/rest/content/event/management/info", data, function fn_eventInfo_success(dst_id, response) {
            var template = $('#tmp_eventInfoForm').html();
            var templateScript = Handlebars.compile(template);
            var context = response.data;
            var html = templateScript(context);

            $('#eventInfoForm').html(html);

            $('#eventInfoForm #datail_eventIdx').val($("#eventidx").val());
            $('#prizeslct').val(response.data.prizeSlct);

            $('._calendar').datepicker('._calendar', new Date()).on('changeDate', function(dateText, inst) {
                var selectDate = moment(dateText.date).format('YYYY.MM.DD');
                $(this).val(selectDate);
            });

            if(response.data.alwaysYn == 1) {

                $('#eventEndDate').val("");
                $('#eventEndDate').prop('disabled', true);

                $('#alwaysYnCheck').attr('checked', true);
            }

            if(response.data.addInfoSlct != 9) {
                $('#etcUrl').attr('readonly', true);
            }

            var prizeWinner = response.data.prizeWinner;
            $('#prizewinner').val(prizeWinner);
            if(prizeWinner == 1) {
                $('#tab_eventWinnerAnnounce').removeAttr('disabled');
            } else if(prizeWinner == 0) {
                $('#tab_eventWinnerAnnounce').attr('disabled', true);
            }
        });
    }

    $(document).on('click', '#alwaysYnCheck', function() {
        if($(this).prop('checked')) {
            $('#eventEndDate').val("");
            $('#eventEndDate').prop('disabled', true);
        } else {
            $('#eventEndDate').prop('disabled', false);
            $('#eventEndDate').val(dateTime);
        }
    });

    $(document).on('change', '#addInfoSlct', function() {
       if($(this).val() == 9) {
           $('#etcUrl').attr('readonly', false);
       } else {
           $('#etcUrl').attr('readonly', true);
           $('#etcUrl').val("");
       }
    });

    function inputValidation() {
        var title = $('#eventInfoForm #title');
        if(common.isEmpty(title.val())) {
            alert('이벤트 제목을 입력해주세요.');
            title.focus();
            return false;
        }

        var viewyn = $('input[name="viewYn"]:checked').val();
        if(common.isEmpty(viewyn)) {
            alert('이벤트 노출 여부를 선택해주세요.');
            return false;
        }

        if($('#prizewinner') == 1) {
            var announceyn = $('input[name="announceYn"]:checked').val();
            if (common.isEmpty(announceyn)) {
                alert('발표결과 노출 여부를 선택해주세요.');
                return false;
            }
        }

        if($('#addInfoSlct').val() == 9) {
            if(common.isEmpty($('#etcUrl').val())) {
                alert('추가 정보를 입력해주세요.');
                return false;
            }
        }

        return true;

    }

    function getAddParameter() {
        return data = {
            title : $('#title').val()
            , alwaysYn : $('input[name="alwaysYnCheck"]').is(':checked') ? 1 : 0
            , startDate : $('#eventStartDate').val().replace(/\./g, '-')
            , endDate : $('#eventEndDate').val().replace(/\./g, '-')
            , viewYn : $('input[name="viewYn"]:checked').val()
            , announceYn : $('input[name="announceYn"]:checked').val()
            , prizeSlct : $('#prizeSlct').val()
            , addInfoSlct : $('#addInfoSlct').val()
            , etcUrl : $('#etcUrl').val()
            , pcLinkUrl : $('#pcLinkUrl').val()
            , mobileLinkUrl : $('#mobileLinkUrl').val()
            , listImgUrl : $('#listImgUrl').val()
            , announcementDate : $('#announcementDate').val().replace(/\./g, '-')
        };
    }

    $(document).on('click', '#bt_registerEvent', function() {
        if(inputValidation()) {
            if(confirm('등록하시겠습니까?')) {
                util.getAjaxData("eventAdd", "/rest/content/event/management/add", getAddParameter(), function fn_eventAdd_success(dst_id, response) {
                    alert(response.message);
                    location.reload();
                });
            }
        }
    });

    function getUpdateParameter() {
        return data = {
            eventIdx : $('#eventidx').val()
            , title : $('#title').val()
            , alwaysYn : $('input[name="alwaysYnCheck"]').is(':checked') ? 1 : 0
            , startDate : $('#eventStartDate').val().replace(/\./g, '-')
            , endDate : $('#eventEndDate').val().replace(/\./g, '-')
            , viewYn : $('input[name="viewYn"]:checked').val()
            , announceYn : $('input[name="announceYn"]:checked').val()
            , prizeSlct : $('#prizeSlct').val()
            , addInfoSlct : $('#addInfoSlct').val()
            , etcUrl : $('#etcUrl').val()
            , pcLinkUrl : $('#pcLinkUrl').val()
            , mobileLinkUrl : $('#mobileLinkUrl').val()
            , listImgUrl : $('#listImgUrl').val()
            , announcementDate : $('#announcementDate').val().replace(/\./g, '-')
        };
    }

    $(document).on('click', '#bt_updateEvent', function() {
        if(inputValidation()) {
            if(confirm('수정하시겠습니까?')) {
                util.getAjaxData("eventUpdate", "/rest/content/event/management/edit", getUpdateParameter(), function fn_eventUpdate_success(dst_id, response) {
                    alert(response.message);
                    location.reload();
                });
            }
        }
    });

    $(document).on('click', '#bt_deleteOneEvent', function() {
        if(confirm('해당 이벤트를 삭제하시겠습니까?')) {
            var data = {
                eventIdx : $('#eventidx').val()
            };
            util.getAjaxData("eventDeleteOne", "/rest/content/event/management/delete", data, function fn_eventDeleteOne_success(dst_id, response) {
               alert(response.message);
               location.reload();
            });
        }
    });

    function getImg(targetName) {
        var imgUrl = $('input[name="'+targetName+'"]').val();
        if(imgUrl.length == 0) {
            alert('이미지 url을 확인하여 주시기 바랍니다.');
            return false;
        }
        $('#'+targetName+'Viewer').attr('src', imgUrl);
        $('#'+targetName+'Viewer').attr('onerror', 'imgError(this.src)');
    }

    function imgError(imgURL) {
        if(imgURL.length > 0){
            alert("이미지 URL이 정상적이지 않습니다.\n입력 URL :" + imgURL);
        }
    }

    function eventDetail_fullSize(url) {     // 이미지 full size
        $("#eventDetail_fullSize").html(util.imageFullSize("eventDetailFullSize",url));
        $('#eventDetailFullSize').modal('show');
    }

    $(document).on('click', '._pcLinkUrl', function() {
        var tmp = $(this).data('pclink');
        util.windowOpen(tmp, '800', '800', '이벤트 PC 상세 링크');
    });

    $(document).on('click', '._mobileLinkUrl', function() {
        var tmp = $(this).data('mobilelink');
        util.windowOpen(tmp, '800', '800', '이벤트 mobile 상세 링크');
    });
</script>

<script id="tmp_eventInfoForm" type="text/x-handlebars-template">
    <input type="hidden" name="datail_eventIdx" id="datail_eventIdx"/>
    <div class="row col-lg-12">
        <table class="table table-bordered table-dalbit">
            <colgroup>
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="8%" />
                <col width="10%" />
            </colgroup>
            <tbody>
            <tr class="align-middle">
                <th>이벤트 제목</th>
                <td colspan="5"><input type="text" class="form-control" style="width:100%;" id="title" name="title" placeholder="이벤트 제목을 입력하세요." value="{{replaceHtml title}}"></td>
                <th>이벤트 상태</th>
                <td>{{{getCommonCodeLabel state 'event_stateSlct'}}}</td>
            </tr>
            <tr>
                <th>이벤트 기간</th>
                <td colspan="3">
                    <div class="form-inline" id="eventPeriod">
                        <div class="input-group date" id="div-eventStartDate">
                            <label for="eventStartDate" class="input-group-addon">
                                <span><i class="fa fa-calendar" id="eventStartDateBtn"></i></span>
                            </label>
                            <input type="text" class="form-control _calendar" id="eventStartDate" name="eventStartDate" value="{{convertToDate startDate 'YYYY.MM.DD'}}">
                        </div>
                        <span> ~ </span>
                        <div class="input-group date" id="div-eventEndDate">
                            <label for="eventEndDate" class="input-group-addon">
                                <span><i class="fa fa-calendar" id="eventEndDateBtn"></i></span>
                            </label>
                            <input type="text" class="form-control _calendar" id="eventEndDate" name="eventEndDate" value="{{convertToDate endDate 'YYYY.MM.DD'}}">
                        </div>
                    </div>
                    <input type="checkbox" id="alwaysYnCheck" name="alwaysYnCheck"/> <label for="alwaysYnCheck">상시 이벤트</label>
                </td>
                <th>노출여부</th>
                <td>
                    {{{getCommonCodeRadio viewYn 'event_viewYn'}}}
                </td>
                <th>당첨자 발표</th>
                <td>
                    {{#equal prizeWinner '1'}}
                    {{{getCommonCodeRadio ../announceYn 'event_announceYn_radio'}}}
                    {{else}}
                    (당첨자 집계 중)
                    {{/equal}}
                </td>
            </tr>
            <tr>
                <th>등록일</th>
                <td>{{regDate}}</td>
                <th>등록자</th>
                <td>{{regOpName}}</td>
                <th>최종수정일</th>
                <td>{{lastUpdDate}}</td>
                <th>최종수정자</th>
                <td>{{lastOpName}}</td>
            </tr>
            <tr>
                <th>추가 정보</th>
                <td colspan="3">
                    {{{getCommonCodeSelect addInfoSlct 'event_addInfoSlct'}}}
                    <input type="text" style="width:80%;" id="etcUrl" name="etcUrl" class="form-control _trim" value="{{etcUrl}}" placeholder="기타 선택 시 추가 URL을 입력해주세요."/>
                </td>
                <th>경품 구분</th>
                <td>{{{getCommonCodeSelect prizeSlct 'event_prizeSlct'}}}</td>
                <th>당첨자 발표 날짜</th>
                <td>
                    <div class="form-inline">
                        <div class="input-group date" id="div-announcementDate">
                            <label for="announcementDate" class="input-group-addon" style="width:10%;">
                                <span><i class="fa fa-calendar" id="announcementDateBtn"></i></span>
                            </label>
                            <input type="text" style="width:100%;" class="form-control _calendar" id="announcementDate" name="announcementDate" value="{{convertToDate announcementDate 'YYYY.MM.DD'}}">
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th>이벤트 상세(PC)</th>
                <td colspan="7">
                    <input type="text" class="form-control _trim pull-left" id="pcLinkUrl" name="pcLinkUrl" placeholder="PC 상세 이미지 링크" style="width:70%" value="{{pcLinkUrl}}">
                    <button type="button" class="_pcLinkUrl btn btn-default btn-sm pull-right" data-pclink="{{pcLinkUrl}}">미리보기</button>
                </td>
            </tr>
            <tr>
                <th>이벤트 상세(Mobile)</th>
                <td colspan="7">
                    <input type="text" class="form-control _trim pull-left" id="mobileLinkUrl" name="mobileLinkUrl" placeholder="Mobile 상세 이미지 링크" style="width:70%" value="{{mobileLinkUrl}}">
                    <button type="button" class="_mobileLinkUrl btn btn-default btn-sm pull-right" data-mobilelink="{{mobileLinkUrl}}">미리보기</button>
                </td>
            </tr>
            <tr>
                <th>리스트 이미지</th>
                <td colspan="7">
                    <input type="text" class="form-control _trim pull-left" id="listImgUrl" name="listImgUrl" placeholder="이벤트 목록에 보일 이미지 링크" style="width:70%" value="{{listImgUrl}}">
                    <button type="button" class="btn btn-default btn-sm pull-right" onclick="getImg('listImgUrl')">미리보기</button>
                </td>
            </tr>
            <tr>
                <td colspan="8">
                    <!--미리보기-->
                    <img id="listImgUrlViewer" class="thumbnail" style="max-width:360px; max-height:450px;" onclick="eventDetail_fullSize(this.src);"/>
                </td>
            </tr>
            </tbody>
        </table>
        <div class="form-inline pull-left">
            {{#state}}<button class="btn btn-danger btn-sm" type="button" id="bt_deleteOneEvent">이벤트 삭제</button>{{/state}}
        </div>
        <div class="form-inline pull-right">
            {{^state}}<button class="btn btn-default btn-sm" type="button" id="bt_registerEvent">등록하기</button>{{/state}}
            {{#state}}<button class="btn btn-default btn-sm" type="button" id="bt_updateEvent">수정하기</button>{{/state}}
        </div>
    </div>
</script>