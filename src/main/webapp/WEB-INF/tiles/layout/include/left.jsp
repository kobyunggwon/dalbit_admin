<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="cfn" uri="/WEB-INF/tld/comFunction.tld" %>

<c:set var="url" value="${requestScope['javax.servlet.forward.request_uri']}" />
<c:set var="param" value="${requestScope['javax.servlet.forward.query_string']}" />
<c:set var="param_menu" value="${param.menu}" />

<!-- left sidebar -->
<div id="left-sidebar" class="left-sidebar ">
    <!-- main-nav -->
    <div class="sidebar-scroll" style="overflow:auto; height: 100%">
        <nav class="main-nav">
            <ul class="main-menu">

                <c:forEach var="menu" items="${cfn:getMenuList()}" varStatus="status">
                    <c:if test="${menu.menu_name eq '메인'}">
                        <c:set var="isContainSubmenu" value="${0 < fn:length(menu.twoDepth)}" />
                        <c:set var="isSubmenuView" value="false" />

                        <c:if test="${url.equals(menu.menu_url)}">
                            <c:set var="isSubmenuView" value="true" />
                        </c:if>
                        <c:forEach var="subMenu" items="${menu.twoDepth}">
                            <c:if test="${url.equals(subMenu.menu_url)}">
                                <c:set var="isSubmenuView" value="true" />
                            </c:if>
                        </c:forEach>

                        <li class="${menu.menu_url eq '/main' ? '_mainMenu' : ''} ${isContainSubmenu ? '' : 'page'} ${menu.is_comming_soon eq 1 ? '_commingSoon' : ''} ${isSubmenuView ? 'active': ''}"
                            data-isread="${menu.is_read}" data-isinsert="${menu.is_insert}" data-isdelete="${menu.is_delete}"
                        >

                            <a href="${menu.menu_url}" class="${isContainSubmenu ? 'js-sub-menu-toggle' : ''}">
                                <i class="fa ${menu.icon}"></i><span class="text">${menu.menu_name}</span>
                                <c:if test="${isContainSubmenu}">
                                    <i class="toggle-icon fa fa-angle-${isSubmenuView ? 'down': 'left'}"></i>
                                </c:if>
                            </a>

                            <c:if test="${isContainSubmenu}">
                                <ul class="sub-menu" style="${isSubmenuView ? 'display:block;': ''}">
                                    <c:forEach var="twoDepth" items="${menu.twoDepth}">
                                        <li class="${fn:contains(url, twoDepth.menu_url) ? 'active': ''}">
                                            <a href="${twoDepth.menu_url}" class="${twoDepth.is_comming_soon eq 1 ? '_commingSoon' : ''}">
                                                <i class="fa fa-thumbs-o-up"></i><span class="text">${twoDepth.menu_name}</span>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </c:if>
                        </li>
                    </c:if>
                </c:forEach>

                <c:forEach var="menu" items='${sessionScope.InforexMenuInfo}'>
                    <c:if test="${menu.depth eq 1}">
                        <li>
                            <a href="javascript://" class="js-sub-menu-toggle">
                                <span class="text">${menu.name}</span>
                                <i class="toggle-icon fa fa-angle-left"></i>
                            </a>
                            <c:forEach var="menu2" items='${sessionScope.InforexMenuInfo}'>
                                <c:if test="${menu2.depth eq 2 && menu.id eq menu2.id}">
                                    <ul class="sub-menu">
                                        <li>
                                            <a href="javascript://" data-url="${menu2.url}" class="_inforex">
                                                <span class="text">${menu2.name}</span>
                                            </a>
                                        </li>
                                    </ul>
                                </c:if>
                            </c:forEach>
                        </li>
                    </c:if>
                </c:forEach>

                <c:forEach var="menu" items="${cfn:getMenuList()}" varStatus="status">
                    <c:if test="${menu.menu_name ne '메인'}">
                        <c:set var="isContainSubmenu" value="${0 < fn:length(menu.twoDepth)}" />
                        <c:set var="isSubmenuView" value="false" />

                        <c:if test="${url.equals(menu.menu_url)}">
                            <c:set var="isSubmenuView" value="true" />
                        </c:if>
                        <c:forEach var="subMenu" items="${menu.twoDepth}">
                            <c:if test="${url.equals(subMenu.menu_url)}">
                                <c:set var="isSubmenuView" value="true" />
                            </c:if>
                        </c:forEach>

                        <li class="${menu.menu_url eq '/main' ? '_mainMenu' : ''} ${isContainSubmenu ? '' : 'page'} ${menu.is_comming_soon eq 1 ? '_commingSoon' : ''} ${isSubmenuView ? 'active': ''}"
                            data-isread="${menu.is_read}" data-isinsert="${menu.is_insert}" data-isdelete="${menu.is_delete}"
                        >

                            <a href="${0 < fn:length(menu.menu_url) ? 'javascript://' : menu.menu_url}" class="${isContainSubmenu ? 'js-sub-menu-toggle' : ''}">
                                <i class="fa ${menu.icon}"></i><span class="text">${menu.menu_name}</span>
                                <c:if test="${isContainSubmenu}">
                                    <i class="toggle-icon fa fa-angle-${isSubmenuView ? 'down': 'left'}"></i>
                                </c:if>
                            </a>

                            <c:if test="${isContainSubmenu}">
                                <ul class="sub-menu" style="${isSubmenuView ? 'display:block;': ''}">
                                    <c:forEach var="twoDepth" items="${menu.twoDepth}">
                                        <li class="${url.equals(twoDepth.menu_url) ? 'active': ''}"
                                            data-isread="${twoDepth.is_read}" data-isinsert="${twoDepth.is_insert}" data-isdelete="${twoDepth.is_delete}"
                                        >
                                            <a href="${0 == fn:length(twoDepth.menu_url) ? 'javascript://' : twoDepth.menu_url}" class="${twoDepth.is_comming_soon eq 1 ? '_commingSoon' : ''}">
                                                <i class="fa fa-thumbs-o-up"></i><span class="text">${twoDepth.menu_name}</span>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </c:if>
                        </li>
                    </c:if>
                </c:forEach>


                <li class="${fn:startsWith(url, '/sample/') ? 'active': ''}">
                    <a href="javascript://" class="js-sub-menu-toggle">
                        <i class="fa fa-question"></i><span class="text">샘플페이지</span>
                        <i class="toggle-icon fa fa-angle-${fn:startsWith(url, '/sample/') ? 'down': 'left'}"></i>
                    </a>
                    <ul class="sub-menu" style="${fn:startsWith(url, '/sample/') ? 'display:block;': ''}">
                        <li class="${fn:contains(url, '/sample/editor') ? 'active': ''}">
                            <a href="/sample/editor">
                                <i class="fa fa-search"></i><span class="text">에디터</span>
                            </a>
                        </li>
                        <li class="${fn:contains(url, '/sample/chart') ? 'active': ''}">
                            <a href="/sample/chart">
                                <i class="fa fa-search"></i><span class="text">차트</span>
                            </a>
                        </li>
                        <li class="${fn:contains(url, '/sample/datepicker') ? 'active': ''}">
                            <a href="/sample/datepicker">
                                <i class="fa fa-search"></i><span class="text">DatePicker</span>
                            </a>
                        </li>
                        <li class="${fn:contains(url, '/sample/layer') ? 'active': ''}">
                            <a href="/sample/layer">
                                <i class="fa fa-search"></i><span class="text">레이어</span>
                            </a>
                        </li>
                        <li class="${fn:contains(url, '/sample/function') ? 'active': ''}">
                            <a href="/sample/function">
                                <i class="fa fa-search"></i><span class="text">공통함수</span>
                            </a>
                        </li>
                        <li class="${url.equals('/sample/inforexAdminLogin') ? 'active': ''}">
                            <a href="/sample/inforexAdminLogin">
                                <i class="fa fa-search"></i><span class="text">인포렉스 로그인 연동</span>
                            </a>
                        </li>
                        <li class="${url.equals('/sample/inforexAdminMenu') ? 'active': ''}">
                            <a href="/sample/inforexAdminMenu">
                                <i class="fa fa-search"></i><span class="text">인포렉스 메뉴 가져오기</span>
                            </a>
                        </li>
                        <li class="${url.equals('/sample/inforexPosCodeList') ? 'active': ''}">
                            <a href="/sample/inforexPosCodeList">
                                <i class="fa fa-search"></i><span class="text">인포렉스 API 조회</span>
                            </a>
                        </li>
                        <li class="${fn:contains(url, '/sample/confirmError') ? 'active': ''}">
                            <a href="/sample/confirmError">
                                <i class="fa fa-search"></i><span class="text">에러확인</span>
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </nav>
        <!-- /main-nav -->
    </div>
</div>
<!-- end left sidebar -->

<script type="text/javascript">

    $('._commingSoon').on('click', function(e){
        <c:if test="${fn:contains('/dev/', cfn:getActiveProfile())}">
            e.preventDefault();
            alert('준비중입니다.');
        </c:if>
    });

    $('._commingSoon').find('span').css({
        'color' : 'gray',
        'font-weight' : 'bold'
    }).append(' - 준비중');

    $('._inforex').on('click', function(){
        ui.loadInforexAdminPage($(this));
    });

    $('.main-menu li:first').before($('._mainMenu'));
</script>