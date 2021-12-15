
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>성상은_사전과제</title>
    <link rel="stylesheet" type="text/css" href="/css/main.css?v=4">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
</head>
<body>
<div id="header">
    <div class="logo">
        <a href="/" class="menuA"><img src="/img/logo.png" width="75" height="50"></a>
    </div>
    <div class="nav_list">
        <c:choose>
            <c:when test="${empty sessionScope.principal}">
                <ul class="nav_ul">
                    <li class="menu"><a href="/auth/loginForm" class="menuA">로그인</a></li>
                    <li class="menu"><a href="/auth/joinForm" class="menuA">회원가입</a></li>
                </ul>
            </c:when>
            <c:when test="${sessionScope.principal.role == 'ADMIN'}">
                <ul class="nav_ul">
                    <li class="menu">${sessionScope.principal.userName}님</li>
                    <li class="menu"><a href="/user/ad_joinForm" class="menuA">업체/기사 등록</a></li>
                    <li class="menu"><a href="/order/orderList" class="menuA">주문 리스트</a></li>
                    <li class="menu"><a href="/complain/List" class="menuA">클레임 리스트</a></li>
                    <li class="menu"><a href="/voc/driList/" class="menuA">VOC/배상 관리</a></li>
                    <li class="menu"><a href="/auth/logout" class="menuA">로그아웃</a></li>
                </ul>
            </c:when>
            <c:when test="${sessionScope.principal.role == 'CLIENT'}">
                <ul class="nav_ul">
                    <li class="menu">${sessionScope.principal.userName}님</li>
                    <li class="menu">정산금 : ${sessionScope.principal.totalMoney}원</li>
                    <li class="menu"><a href="/order/orderList" class="menuA">주문 리스트</a></li>
                    <li class="menu"><a href="/order/orderList/client/${sessionScope.principal.userNum}" class="menuA">내 오더 관리</a></li>
                    <li class="menu"><a href="/voc/cliList/" class="menuA">클레임/배상 관리</a></li>
                    <li class="menu"><a href="/auth/logout" class="menuA">로그아웃</a></li>
                </ul>
            </c:when>
            <c:when test="${sessionScope.principal.role == 'DRIVER' || sessionScope.principal.role == 'AGENCY'}">
                <ul class="nav_ul">
                    <li class="menu">${sessionScope.principal.userName}님</li>
                    <li class="menu">정산금 : ${sessionScope.principal.totalMoney}</li>
                    <li class="menu"><a href="/order/orderList" class="menuA">주문 리스트</a></li>
                    <li class="menu"><a href="/order/orderList/driver/${sessionScope.principal.userNum}" class="menuA">내 배송 관리</a></li>
                    <li class="menu"><a href="/voc/driList/" class="menuA">VOC/배상 관리</a></li>
                    <li class="menu"><a href="/auth/logout" class="menuA">로그아웃</a></li>
                </ul>
            </c:when>
        </c:choose>

    </div>
</div>
<br><br><br>