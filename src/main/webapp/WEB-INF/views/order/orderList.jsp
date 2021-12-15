<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<jsp:include page="../layout/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/order.css">


<div id="container">
    <div id="list_wrap">
        <h2>전체 오더리스트</h2>
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
            <c:forEach var="orderList" items="${orderList}">
                <tr height="50px">
                    <td>
                            ${orderList.orderNum}
                        <input type="hidden" class="orderNum" id="orderNum${orderList.orderNum}" name="orderNum" value="${orderList.orderNum}">
                    </td>
                    <td>${orderList.client.userName}</td>
                    <td>${orderList.departure}</td>
                    <td>${orderList.destination}</td>
                    <td>${orderList.price}</td>
                    <td>${orderList.requestTime}</td>
                    <c:choose>
                        <c:when test="${empty orderList.driver}">
                            <td>미 배정</td>
                        </c:when>
                        <c:otherwise>
                            <td>${orderList.driver.userName}</td>
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${orderList.progress eq'INFORM'}">
                            <c:choose>
                                <c:when test="${sessionScope.principal.role =='ADMIN' || sessionScope.principal.role == 'CLIENT'}">
                                    <td>기사배정중 </td>
                                    <td><a href="/order/detail/${orderList.orderNum}" class="inform">상세</a></td>
                                </c:when>
                                <c:when test="${sessionScope.principal.role =='DRIVER' || sessionScope.principal.role == 'AGENCY'}">
                                    <td>기사배정중</td>
                                    <td><a href="#" class="inform" onclick="doAction(${orderList.orderNum})">접수</a></td>
                                </c:when>
                            </c:choose>
                        </c:when>
                        <c:when test="${orderList.progress eq'TAKE'}">
                            <c:choose>
                                <c:when test="${sessionScope.principal.role =='ADMIN' || sessionScope.principal.role == 'CLIENT'}">
                                    <td>배송중</td>
                                    <td><a href="/order/detail/${orderList.orderNum}" class="inform">상세</a></td>
                                </c:when>
                                <c:when test="${sessionScope.principal.role =='DRIVER' || sessionScope.principal.role == 'AGENCY'}">
                                    <td>배송중</td>
                                    <td><a href="#" class="inform" style="pointer-events: none;" onclick="doAction(${orderList.orderNum})">접수</a></td>
                                </c:when>
                            </c:choose>
                        </c:when>
                        <c:when test="${orderList.progress eq'DELIVERED'}">
                            <c:choose>
                                <c:when test="${sessionScope.principal.role =='ADMIN' || sessionScope.principal.role == 'CLIENT'}">
                                    <td>배송완료</td>
                                    <td><a href="/order/detail/${orderList.orderNum}" class="inform">상세</a></td>
                                </c:when>
                                <c:when test="${sessionScope.principal.role =='DRIVER' || sessionScope.principal.role == 'AGENCY'}">
                                    <td>배송완료</td>
                                    <td><a href="#" class="inform" style="pointer-events: none;" onclick="doAction(${orderList.orderNum})">접수</a></td>
                                </c:when>
                            </c:choose>
                        </c:when>
                        <c:when test="${orderList.progress eq'APPROVED'}">
                            <c:choose>
                                <c:when test="${sessionScope.principal.role =='ADMIN' || sessionScope.principal.role == 'CLIENT'}">
                                    <td>종료</td>
                                    <td><a href="/order/detail/${orderList.orderNum}" class="inform">상세</a></td>
                                </c:when>
                                <c:when test="${sessionScope.principal.role =='DRIVER' || sessionScope.principal.role == 'AGENCY'}">
                                    <td>종료</td>
                                    <td><a href="#" class="inform" style="pointer-events: none;" onclick="doAction(${orderList.orderNum})">접수</a></td>
                                </c:when>
                            </c:choose>
                        </c:when>
                        <c:when test="${orderList.progress eq'CLAIM'}">
                            <c:choose>
                                <c:when test="${sessionScope.principal.role =='ADMIN' || sessionScope.principal.role == 'CLIENT'}">
                                    <td>클레임</td>
                                    <td><a href="/order/detail/${orderList.orderNum}" class="inform">상세</a></td>
                                </c:when>
                                <c:when test="${sessionScope.principal.role =='DRIVER' || sessionScope.principal.role == 'AGENCY'}">
                                    <td>클레임</td>
                                    <td><a href="#" class="inform" style="pointer-events: none;" onclick="doAction(${orderList.orderNum})">접수</a></td>
                                </c:when>
                            </c:choose>
                        </c:when>
                    </c:choose>

                </tr>
            </c:forEach>
        </table>
        <div class="btn">
            <c:if test="${sessionScope.principal.role == 'CLIENT'}">
                <button onclick="location.href='/order/orderWriteForm'">오더 등록</button>
            </c:if>
        </div>
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