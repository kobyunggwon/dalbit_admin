<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="wrapper">
    <div id="page-wrapper">
        <div class="container-fluid">
            <!-- serachBox -->
            <form id="searchForm">
            <div class="row col-lg-12 form-inline">
                <input type="hidden" name="pageStart" id="pageStart">
                <input type="hidden" name="pageCnt" id="pageCnt">
                <div class="widget widget-table searchBoxArea">
                    <div class="widget-header searchBoxRow">
                        <h3 class="title"><i class="fa fa-search"></i> 추천/인기DJ 검색</h3>
                        <div>
                            <span id="searchArea"></span>
                            <label><input type="text" class="form-control" id="txt_search" name="txt_search"></label>
                            <button type="button" class="btn btn-success" id="bt_search">검색</button>
                        </div>
                    </div>
                </div>
            </div>
            </form>
            <!-- //serachBox -->
            <!-- DATA TABLE -->
            <div class="row col-lg-12 form-inline">

                <ul class="nav nav-tabs nav-tabs-custom-colored" role="tablist" id="rankTab">
                    <li class="active">
                        <a href="#djRankList" role="tab" data-toggle="tab" data-rank="djRankList"><i class="fa fa-home"></i> DJ랭킹</a>
                    </li>
                    <li>
                        <a href="#fanRankList" role="tab" data-toggle="tab" data-rank="fanRankList"><i class="fa fa-user"></i> Fan랭킹</a>
                    </li>
                </ul>
                <div>
                    <div>
                        <div class="row col-lg-12 form-inline">
                            <div class="table-comment pt10 pull-left">
                                DJ/Fan랭킹 Main 노출 수는 1위부터 5위까지 총5명입니다.
                            </div>

                            <div class="table-option pt10 pull-right">
                                <label class="control-inline fancy-radio custom-color-green">
                                    <input type="radio" name="rankType" value='1' checked="checked" />
                                    <span><i></i>일간</span>
                                </label>
                                <label class="control-inline fancy-radio custom-color-green">
                                    <input type="radio" name="rankType" value='2' />
                                    <span><i></i>주간</span>
                                </label>
                                <label class="control-inline fancy-radio custom-color-green">
                                    <input type="radio" name="rankType" value='3' />
                                    <span><i></i>월간</span>
                                </label>
                            </div>
                        </div>

                        <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate_top"></div>

                        <table id="list_info" class="table table-sorting table-hover table-bordered">
                        </table>
                        <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>
                    </div>


                    <%--<div class="dataTables_paginate paging_full_numbers" id="list_info_paginate">--%>
                        <%--<ul class="pagination borderless">
                            <li class="paginate_button first" aria-controls="list_info" tabindex="0"
                                id="list_info_first"><a href="#">처음</a></li>
                            <li class="paginate_button previous" aria-controls="list_info" tabindex="0"
                                id="list_info_previous"><a href="#">이전</a></li>
                            <li class="paginate_button active" aria-controls="list_info" tabindex="0"><a href="#">1</a>
                            </li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">2</a></li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">3</a></li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">4</a></li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">5</a></li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">6</a></li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">7</a></li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">8</a></li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">9</a></li>
                            <li class="paginate_button " aria-controls="list_info" tabindex="0"><a href="#">10</a></li>
                            <li class="paginate_button next" aria-controls="list_info" tabindex="0" id="list_info_next">
                                <a href="#">다음</a></li>
                            <li class="paginate_button last" aria-controls="list_info" tabindex="0" id="list_info_last">
                                <a href="#">마지막</a></li>
                        </ul>--%>
                    <%--</div>--%>

                </div>
            </div>
            <!-- DATA TABLE END -->
        </div>
    </div>
</div>
<!-- 이미지 원본 보기 -->
<div id="imageFullSize"></div>

<script type="text/javascript" src="/js/code/menu/menuCodeList.js?${dummyData}"></script>
<script type="text/javascript">
     djRankListPagingInfo = new PAGING_INFO(0, 1, 50);

    $(function(){
        $("#searchArea").html(util.getCommonCodeSelect(9999, searchType));
        init();
    });

    function init(tabName){

        var rank = common.isEmpty(tabName) ? $('#rankTab li.active a').data('rank') : tabName;
        var data = {
            rankType : $('input:radio[name="rankType"]:checked').val()
            , pageStart : djRankListPagingInfo.pageNo
            , pageCnt : djRankListPagingInfo.pageCnt
            , selectGubun : $('#searchArea').val()
            , txt_search : $("#txt_search").val()
        }
        util.getAjaxData(rank, "/rest/menu/rank/"+rank, data, fn_succ_list);
    }


    function fn_succ_list(dst_id, response, params) {
        dalbitLog(dst_id);
        dalbitLog(response);

        var template = $('#tmp_'+dst_id).html();
        var templateScript = Handlebars.compile(template);
        var context = response.data;
        var html = templateScript(context);
        $("#list_info").html(html);

        var pagingInfo = response.pagingVo;
        djRankListPagingInfo.totalCnt = pagingInfo.totalCnt;
        util.renderPagingNavigation('list_info_paginate_top', djRankListPagingInfo);
        util.renderPagingNavigation('list_info_paginate', djRankListPagingInfo);
    }

    $('input[name="rankType"]').on('change', function(){
        djRankListPagingInfo.pageNo = 1;
        init();
    });

    $('#rankTab li').on('click', function(){
        var rank = $(this).find('a').data('rank');
        djRankListPagingInfo.pageNo = 1;
        init(rank);
    });

    $('#bt_search').on('click', function() {
        init($('#rankTab li.active a').data('rank'));
    });

    $('input[id="txt_search"]').on('keydown', function(e) {
        if(e.keyCode == 13) {
            init($('#rankTab li.active a').data('rank'));
        };
    });

    function handlebarsPaging(targetId, pagingInfo){
        djRankListPagingInfo = pagingInfo;
        init();
    }

     function fullSize_profile(url) {     // 이미지 full size
         $("#imageFullSize").html(util.imageFullSize("fullSize_profile",url));
         $('#fullSize_profile').modal('show');
     }
     function modal_close(){
         $("#fullSize_profile").modal('hide');
     }
     mouseOver();
     function mouseOver(){
         var xOffset = 10;
         var yOffset = 30;

         $(document).on("mouseover",".thumbnail",function(e){ //마우스 오버
             $("body").append("<p id='preview'><img src='"+ $(this).attr("src") +"' width='400px' /></p>"); //이미지
             $("#preview")
                 .css("top",(e.pageY - xOffset) + "px")
                 .css("left",(e.pageX + yOffset) + "px")
                 .fadeIn("fast");
         });
         $(document).on("mousemove",".thumbnail",function(e){ //마우스 이동
             $("#preview")
                 .css("top",(e.pageY - xOffset) + "px")
                 .css("left",(e.pageX + yOffset) + "px");
         });
         $(document).on("mouseout",".thumbnail",function(){ //마우스 아웃
             $("#preview").remove();
         });
     }

</script>

<script type="text/x-handlebars-template" id="tmp_djRankList">
    <thead id="djtableTop">
    <tr>
        <th>순위</th>
        <th>Main 추천상태</th>
        <th>프로필 이미지</th>
        <th>User ID</th>
        <th>User 닉네임</th>
        <th>보유결제금액</th>
        <th>누적 받은 별</th>
        <th>누적 받은 선물</th>
        <th>누적 방송 횟수</th>
        <th>최초 방송 시작일</th>
        <th>총 방송진행 시간</th>
    </tr>
    </thead>
    <tbody id="djRankListBody">
    {{#each this as |rank|}}
        <tr>
            <td>
                {{djRank}} <br /><br />
                {{upDown}}
            </td>
            <td>
                {{#isSmall djRank '6'}}
                <i class="fa fa-circle" style="color: blue"></i><br/><span class="text">추천 중</span>

                {{else}}
                <i class="fa fa-circle-o" style="color: blue"></i><br/><span class="text">비추천</span>
                {{/isSmall}}
            </td>
            <td style="width: 50px">
                {{#equal rank.image_profile ''}}
                    <img class="thumbnail" src="{{viewImage '/profile_3/profile.jpg'}}" style='height:50px; width:50px;' onclick="fullSize_profile(this.src)"/>
                {{else}}
                    <img class="thumbnail" src="{{renderImage rank.image_profile}}" style='height:50px; width:50px;' onclick="fullSize_profile(this.src)"/>
                {{/equal}}
            </td>
            <td>
                <a href="javascript://" class="_openMemberPop" data-memNo="{{memNo}}">{{memNo}}</a>
                <br /> <br />
                레벨 : {{level}} <br />
                등급 : {{grade}}
            </td>
            <td>
                {{#equal mem_nick ''}}
                    {{{fontColor '탈퇴회원 입니다.' 0 'red'}}}
                {{else}}
                    {{rank.mem_nick}}
                {{/equal}}
            </td>
            <td>{{money}}</td>
            <td>{{byeol}}</td>
            <td>{{gifted_mem_no}}</td>
            <td>{{airCount}}</td>
            <td>{{#equal rank.start_date ''}}
                -
                {{else}}
                {{rank.start_date}}
                {{/equal}}
            </td>
            <td>{{timeStamp airTime}}</td>
        </tr>

        {{else}}
            <tr>
                <td colspan="11">{{isEmptyData}}</td>
            </tr>
        {{/each}}
    </tbody>
</script>

<script type="text/x-handlebars-template" id="tmp_fanRankList">
    <thead id="tableTop">
    <tr>
        <th>순위</th>
        <th>Main 추천상태</th>
        <th>프로필 이미지</th>
        <th>User ID</th>
        <th>User 닉네임</th>
        <th>보유결제금액</th>
        <th>누적 받은 별</th>
        <th>누적 받은 선물</th>
        <th>누적 방송 횟수</th>
        <th>최초 방송 시작일</th>
        <th>총 방송진행 시간</th>
    </tr>
    </thead>
    <tbody id="fanRankListBody">
    {{#each this as |fan|}}
        <tr>
            <td>
                {{fanRank}} <br /><br />
                {{upDown}}
            </td>
            <td>
                {{#isSmall fanRank '6'}}
                <i class="fa fa-circle" style="color: blue"></i><br/><span class="text">추천 중</span>
                {{else}}
                <i class="fa fa-circle-o" style="color: blue"></i><br/><span class="text">비추천</span>
                {{/isSmall}}
            </td>
            <td style="width: 50px">
                {{#equal fan.image_profile ''}}
                    <img class="thumbnail" src="{{viewImage '/profile_3/profile.jpg'}}" style='height:50px; width:50px;' onclick="fullSize_profile(this.src)"/>
                {{else}}
                    <img class="thumbnail" src="{{viewImage fan.image_profile}}" style='height:50px; width:50px;' onclick="fullSize_profile(this.src)"/>
                {{/equal}}
            </td>
            <td>
                {{mem_id}} <br /> <br />
                레벨 : {{level}} <br />
                등급 : {{grade}}
            </td>
            <td>{{mem_nick}}</td>
            <td>{{money}}</td>
            <td>{{byeol}}</td>
            <td>{{gifted_mem_no}}</td>
            <td>{{airCount}}</td>
            <td>{{#equal fan.start_date ''}}
                -
                {{else}}
                {{fan.start_date}}
                {{/equal}}
            </td>
            <td>{{timeStamp airTime}}</td>
        </tr>

    {{else}}
        <tr>
            <td colspan="11">{{isEmptyData}}</td>
        </tr>
    {{/each}}
    </tbody>
</script>