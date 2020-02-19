<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- SHOW HIDE COLUMNS DATA TABLE -->
<div class="widget widget-table">
    <div class="widget-header">
        <h3>
            <i class="fa fa-table"></i> 방송주제 관리
            <span class="">- 방송 주제를 등록/수정/삭제 관리할 수 있습니다.</span>
        </h3>

    </div>
    <div class="widget-content">
        <table id="list" class="table table-sorting table-hover table-bordered datatable">
            <thead>
                <tr>
                    <th>선택</th>
                    <th>No</th>
                    <th>순서변경</th>
                    <th>적용상태</th>
                    <th>방송주제</th>
                </tr>
            </thead>
            <tbody id="tableBody">

            </tbody>
        </table>

        <div class="btn-toolbar">
            <div class="btn-group" role="group">
                <button type="button" class="btn btn-default"><i class="fa fa-trash-o"></i>선택삭제</button>
                <button type="button" class="btn btn-primary"><i class="fa fa-pencil"></i>선택수정</button>
            </div>

            <div class="btn-group pull-right" role="group">
                <button type="button" class="btn btn-default mr-10" id="addBtn"><i class="fa fa-plus-square"></i>등록</button>
                <button type="button" class="btn btn-primary "><i class="fa fa-floppy-o"></i>적용</button>
            </div>
        </div>
    </div>
</div>
<!-- END SHOW HIDE COLUMNS DATA TABLE -->


<script>
    $(document).ready(function() {
        getAjaxData("list", "/rest/administrate/theme/list", "", fn_success, fn_fail);
    });

    function fn_success(dst_id, response) {
        dalbitLog(response);

        var template = $('#tmp_list').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript(response);

        $("#tableBody").append(html);
    }

    function fn_fail(data, textStatus, jqXHR) {
        dalbitLog(data, textStatus, jqXHR);
    }

    $(document).on('click', '._down', function(){
        var targetTr = $(this).closest('tr');
        var nextTr = targetTr.next();
        targetTr.insertAfter(nextTr);
        resetNo();
    });

    $(document).on('click', '._up', function(){
        var targetTr = $(this).closest('tr');
        var prevTr = targetTr.prev();
        targetTr.insertBefore(prevTr);
        resetNo();
    });

    function resetNo(){
        $('._noTd').each(function(index){
            $(this).html(index + 1);
        });
    }

    $("#addBtn").on('click', function(){
        var newData = {
            no : $('._noTd').length + 1,
            cdNm : '',
            isOff : false,
            readonly : false
        }

        var template = $('#tmp_list').html();
        var templateScript = Handlebars.compile(template);
        var html = templateScript({data : newData});

        $("#tableBody").append(html);
    });

</script>

<script id="tmp_list" type="text/x-handlebars-template">
    {{#data}}
    <tr>
        <td>
            <input type="checkbox" />
        </td>
        <td class="_noTd">{{index @index no}}</td>
        <td>
            <button type="button" class="_down"><i class="toggle-icon fa fa-angle-down"></i></button>
            <button type="button" class="_up"><i class="toggle-icon fa fa-angle-up"></i></button>
        </td>
        <td>
            <div class="control-inline onoffswitch">
                <input type="checkbox" name="useYn" class="onoffswitch-checkbox" id="useYn{{index @index no}}" {{#if isOn}}checked{{/if}}>
                <label class="onoffswitch-label" for="useYn{{index @index no}}">
                    <span class="onoffswitch-inner"></span>
                    <span class="onoffswitch-switch"></span>
                </label>
            </div>
        </td>
        <td>
            <input type="text" value="{{cdNm}}" class="form-control" readonly="true" />
        </td>
    </tr>
    {{/data}}
</script>