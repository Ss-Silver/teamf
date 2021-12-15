<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<jsp:include page="../layout/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd_HH:mm" var="now" />
<link rel="stylesheet" type="text/css" href="/css/order.css">


<div id="container">
    <div id="list_wrap">

        <h3>오더 정보</h3>
        <table class="order_list">
            <tr height="50px">
                <th width="5%">번호</th>
                <th width="10%">고객사</th>
                <th width="70px">출발지</th>
                <th width="70px;">도착지</th>
                <th width="10%">운임</th>
                <th width="15%">요청도착시간</th>
                <th width="10%">진행상황</th>


            </tr>
            <tr height="50px">
                <td>${orderBean.orderNum}</td>
                <td>${orderBean.client.userName}
                    <input type="hidden" id="cliNum" value="${orderBean.client.userNum}">
                </td>
                <td>${orderBean.departure}</td>
                <td>${orderBean.destination}</td>
                <td>${orderBean.price}</td>
                <td>${orderBean.requestTime}</td>
                <c:choose>
                    <c:when test="${orderBean.progress eq'INFORM'}">
                        <td>기사배정중</td>
                    </c:when>
                    <c:when test="${orderBean.progress eq'TAKE'}">
                        <td>배송중</td>
                    </c:when>
                    <c:when test="${orderBean.progress eq'DELIVERED'}">
                        <td>배송완료</td>
                    </c:when>
                    <c:when test="${orderBean.progress eq'APPROVED'}">
                        <td>배송승인</td>
                    </c:when>
                    <c:when test="${orderBean.progress eq'CLAIM'}">
                        <td>클레임</td>
                    </c:when>
                </c:choose>
            </tr>
        </table>

        <h3>기사/운송사 정보</h3>
        <table id="driver" class="order_list" width="500px">
            <tr height="50px">
                <th width="30%">운송사/기사 이름</th>
                <th width="30%">연락처</th>
                <th>배달 완료시간</th>
            </tr>
            <tr height="50px">
                <td>${orderBean.driver.userName}
                    <input type="hidden" id="driNum" value="${orderBean.driver.userNum}">
                </td>
                <td>${orderBean.driver.phone}</td>
                <td>${orderBean.arriveTime}
                    <input id="nowTime" type="hidden" value="<c:out value="${now}"/>">
                </td>
            </tr>
        </table>
        <br><br>
        <c:choose>
            <c:when test="${orderBean.progress eq'INFORM'}">
                <c:choose>
                    <c:when test="${sessionScope.principal.role =='ADMIN' || sessionScope.principal.role == 'CLIENT'}">
                        <button onclick="location.href='/order/orderList'">전체 리스트</button>
                    </c:when>
                    <c:when test="${sessionScope.principal.role =='DRIVER' || sessionScope.principal.role == 'AGENCY'}">
                        <button onclick="location.href='/order/orderList'">전체 리스트</button>
                    </c:when>
                </c:choose>
            </c:when>
            <c:when test="${orderBean.progress eq'TAKE'}">
                <c:choose>
                    <c:when test="${sessionScope.principal.role =='ADMIN' || sessionScope.principal.role == 'CLIENT'}">
                        <button onclick="location.href='/order/orderList'">전체 리스트</button>
                    </c:when>
                    <c:when test="${sessionScope.principal.role =='DRIVER' || sessionScope.principal.role == 'AGENCY'}">
                        <a href="#" class="inform" onclick="doUpdate(${orderBean.orderNum})">운송 완료</a>
                    </c:when>
                </c:choose>
            </c:when>
            <c:when test="${orderBean.progress eq'DELIVERED'}">
                <c:choose>
                    <c:when test="${sessionScope.principal.role == 'CLIENT'}">
                        <a href="#" class="inform" onclick="doApprove(${orderBean.orderNum})">운송 승인</a>
                        <button onclick="location.href='/complain/form/${orderBean.orderNum}'">클레임</button>
                    </c:when>
                    <c:when test="${sessionScope.principal.role =='DRIVER' || sessionScope.principal.role == 'AGENCY'}">
                        <button onclick="location.href='/order/orderList'">전체 리스트</button>
                    </c:when>
                </c:choose>
            </c:when>
            <c:when test="${orderBean.progress eq'APPROVED'}">
                <c:choose>
                    <c:when test="${sessionScope.principal.role =='ADMIN' || sessionScope.principal.role == 'CLIENT'}">
                        <button onclick="location.href='/order/orderList'">전체 리스트</button>
                    </c:when>
                    <c:when test="${sessionScope.principal.role =='DRIVER' || sessionScope.principal.role == 'AGENCY'}">
                        <button onclick="location.href='/order/orderList'">전체 리스트</button>
                    </c:when>
                </c:choose>
            </c:when>
            <c:when test="${orderBean.progress eq'CLAIM'}">
                <c:choose>
                    <c:when test="${sessionScope.principal.role =='ADMIN' || sessionScope.principal.role == 'CLIENT'}">
                        <button onclick="location.href='/order/orderList'">전체 리스트</button>
                        <button>나중에다시</button>
                    </c:when>
                    <c:when test="${sessionScope.principal.role =='DRIVER' || sessionScope.principal.role == 'AGENCY'}">
                        <button onclick="">클레임 페이지로</button>
                    </c:when>
                </c:choose>
            </c:when>
        </c:choose>

    </div>
</div>

<script src="/js/order.js?v=1"></script>

<jsp:include page="../layout/footer.jsp"/>