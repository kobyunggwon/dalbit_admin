<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- table -->
<div class="row col-lg-12 form-inline">
    <div class="tab-content no-padding">
        <div class="tab-pane fade in active" id="storyList">
            <div class="widget-content">
                <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate_top"></div>
                <div id="storyTable"></div>
                <div class="dataTables_paginate paging_full_numbers" id="list_info_paginate"></div>
            </div>
        </div>
    </div>
</div>
<!-- //table -->

<script type="text/javascript" src="/js/code/content/contentCodeList.js?${dummyData}"></script>
<script type="text/javascript">
    var StoryPagingInfo = new PAGING_INFO(0,1,100);

    $(document).ready(function() {
        $('#title').html('사연검색');
        $('#searchRadio').html(util.getCommonCodeRadio('3', story_searchRadio));
        $('#searchType').html(util.getCommonCodeSelect('-1', story_searchSelect));
        init();
        storyList();
    });

    $('input[id="txt_search"]').keydown(function(e) {
        if(e.keyCode == 13) {
            compare();
            StoryPagingInfo.pageNo = 1;
            storyList();
        }
    });

    $('#bt_search').on('click', function() {
        compare();
        StoryPagingInfo.pageNo = 1;
        storyList();
    });

    function init() {
        var date = new Date();
        var thisYear = date.getFullYear();
        var thisMonth = date.getMonth() + 1;
        $('#start_sel').datepicker("setDate", thisYear + "." + thisMonth + ".01");
        $('#end_sel').datepicker("setDate", date);
    }

    $('#searchRadio').on('change', function() {
       var val =  $('input[name="searchRadio"]:checked').val();
       if(val == 1 || val == 2) {
           $("#start_sel, #end_sel").prop("disabled", true);
       } else {
           $("#start_sel, #end_sel").prop("disabled", false);
       }
    });

    function compare() {
        var startSel = $('#start_sel').val().format('YYYYMMDD');
        alert(startSel);
    }

    function storyList() {
        var data = {
            'pageStart': StoryPagingInfo.pageNo
            , 'pageCnt' : StoryPagingInfo.pageCnt
            , 'txt_search' : $('#txt_search').val()
            , 'searchType' : $('select[name="searchType"]').find('option:selected').val()
            , 'start_sel' : $('#start_sel').val()
            , 'end_sel' : $('#end_sel').val()
        };
        util.getAjaxData("storyList", "/rest/content/boardAdm/storyList", data, fn_success_storyList);
    }

    function fn_success_storyList(dst_id, response) {
        var template = $('#tmp_storyTable').html();
        var templateScript = Handlebars.compile(template);
        var context = response;
        var html = templateScript(context);

        $('#storyTable').html(html);

        StoryPagingInfo.totalCnt = response.pagingVo.totalCnt;
        util.renderPagingNavigation('list_info_paginate_top', StoryPagingInfo);
        util.renderPagingNavigation('list_info_paginate', StoryPagingInfo);

        if(response.data.length == 0) {
            $("#list_info_paginate_top").hide();
            $('#list_info_paginate').hide();
        } else {
            $("#list_info_paginate_top").show();
            $('#list_info.paginate').show();
        }
    }

    function handlebarsPaging(targetId, pagingInfo) {
        StoryPagingInfo = pagingInfo;
        storyList();
    }

</script>

<script id="tmp_storyTable" type="text/x-handlebars-template">
    <table id="tb_storyList" class="table table-sorting table-hover table-bordered mt10">
        <thead>
        <tr>
            <th rowspan="2">No</th>
            <th colspan="3">대상회원</th>
            <th colspan="2">보낸회원</th>
            <th rowspan="2">보낸 일시</th>
            <th rowspan="2">사연 내용</th>
            <th rowspan="2">삭제</th>
        </tr>
        <tr>
            <th>닉네임</th>
            <th>성별 <br />(나이)</th>
            <th>방송제목</th>
            <th>닉네임</th>
            <th>성별 <br />(나이)</th>
        </tr>
        </thead>
        <colgroup>
            <col width="3%"/>
            <col width="10%"/>
            <col width="10%"/>
            <col width="15%"/>
            <col width="10%"/>
            <col width="10%"/>
            <col width="10%"/>
            <col width="20%"/>
            <col width="10%"/>
        </colgroup>
        <tbody>
        {{#each this.data as |data|}}
        <tr>
            <td>{{indexDesc ../pagingVo.totalCnt rowNum}}</td>
            <td>
                {{^equal dj_mem_nick ''}}
                {{../dj_mem_nick}}
                {{else}}
                -
                {{/equal}}
            </td>
            <td>
                {{^equal dj_mem_sex ''}}
                {{{sexIcon ../dj_mem_sex ../dj_birth_year}}}
                {{else}}
                -
                {{/equal}}
            </td>
            <td>{{title}}</td>
            <td>
                {{^equal send_mem_nick ''}}
                {{../send_mem_nick}}
                {{else}}
                -
                {{/equal}}
            </td>
            <td>
                {{^equal send_mem_sex ''}}
                {{{sexIcon ../send_mem_sex ../send_birth_year}}}
                {{else}}
                -
                {{/equal}}
            </td>
            <td>{{convertToDate send_date "YYYY.MM.DD HH:mm:ss"}}</td>
            <td class="word-break">{{story_content}}</td>
            <td><a href="javascript://">[삭제]</a></td>
        </tr>
        {{else}}
        <tr>
            <td colspan="9">{{isEmptyData}}</td>
        </tr>
        {{/each}}
        </tbody>
    </table>
</script>