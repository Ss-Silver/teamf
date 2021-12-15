<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<jsp:include page="../layout/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/order.css">


<div id="container">
    <div id="list_wrap">
        <h2>클레임 오더리스트</h2>
        <hr>
        <table class="order_list">
            <tr height="50px">
                <th width="5%">번호</th>
                <th width="10%">고객사</th>
                <th width="70px">출발지</th>
                <th width="70px;">도착지</th>
                <th width="10%">운임</th>
                <th width="15%">요청도착시간</th>
                <th width="10%">배정기사</th>
                <th width="10%">진행상황</th>
                <th width="5%">선택</th>

            </tr>
            <c:forEach var="complainList" items="${complainList}">
                <tr height="50px">
                    <td>${complainList.orderBean.orderNum}
                        <input type="hidden" class="orderNum" id="orderNum${complainList.orderBean.orderNum}" name="orderNum" value="${complainList.orderBean.orderNum}">
                    </td>
                    <td>${complainList.orderBean.client.userName}</td>
                    <td>${complainList.orderBean.departure}</td>
                    <td>${complainList.orderBean.destination}</td>
                    <td>${complainList.orderBean.price}</td>
                    <td>${complainList.orderBean.requestTime}</td>
                    <td>${complainList.orderBean.driver.userName}</td>
                    <c:choose>
                        <c:when test="${complainList.orderBean.progress eq'APPROVED'}">
                            <td>종료</td>
                        </c:when>
                        <c:when test="${complainList.orderBean.progress eq'CLAIM'}">
                            <td>클레임</td>
                        </c:when>
                    </c:choose>
                    <td><a href="/complain/detail/${complainList.complainNum}" class="inform">상세</a></td>
                </tr>
            </c:forEach>
        </table>
        <br><br>
    </div>
</div>

<div>
    <input type="hidden" id="userNum" value="${sessionScope.principal.userNum}">
    <input type="hidden" id="userId" value="${sessionScope.principal.userId}">
    <input type="hidden" id="password" value="${sessionScope.principal.password}">
    <input type="hidden" id="userName" value="${sessionScope.principal.userName}">
    <input type="hidden" id="phone" value="${sessionScope.principal.phone}">
    <input type="hidden" id="role" value="${sessionScope.principal.role}">
    <input type="hidden" id="totalMoney" value="${sessionScope.principal.totalMoney}">


</div>

<script type="text/javascript" src="/js/order.js?v=1"></script>
<jsp:include page="../layout/footer.jsp"/>