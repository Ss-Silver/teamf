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
                <td>${complain.orderBean.orderNum}</td>
                <td>${complain.orderBean.client.userName}
                    <input type="hidden" id="cliNum" value="${complain.orderBean.client.userNum}">
                </td>
                <td>${complain.orderBean.departure}</td>
                <td>${complain.orderBean.destination}</td>
                <td>${complain.orderBean.price}</td>
                <td>${complain.orderBean.requestTime}</td>
                <c:choose>
                    <c:when test="${complain.orderBean.progress eq'APPROVED'}">
                        <td>종료</td>
                    </c:when>
                    <c:when test="${complain.orderBean.progress eq'CLAIM'}">
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
                <td>${complain.orderBean.driver.userName}
                    <input type="hidden" id="driNum" value="${complain.orderBean.driver.userNum}">
                </td>
                <td>${complain.orderBean.driver.phone}</td>
                <td>${complain.orderBean.arriveTime}
                    <input id="nowTime" type="hidden" value="<c:out value="${now}"/>">
                </td>
            </tr>
        </table>
        <br>

        <h3>클레임 정보</h3>
        <table id="complain" class="order_list" width="800px">
            <tr height="50px">
                <th width="20%">클레임 타입</th>
                <th width="50%">클레임 상세내용</th>
                <th>요청 손해배상금</th>
            </tr>
            <tr height="50px">
                <td>${complain.complainType}</td>
                <td>${complain.complainContent}</td>
                <td>${complain.indemnity} 원</td>
            </tr>
        </table>
        <br><br>
        <button onclick="location.href='/voc/form/${complain.complainNum}'"> VOC 등록</button>
    </div>
    <br><br>
</div>

<script src="/js/order.js?v=1"></script>

<jsp:include page="../layout/footer.jsp"/>