<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<jsp:include page="../layout/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/order.css">


<div id="container">
    <div id="list_wrap">
        <h2>VOC / 배상 현황</h2>
        <hr>
        <table class="order_list">
            <tr height="50px">
                <th width="5%">주문<br>번호</th>
                <th width="10%">고객사</th>
                <th width="10%">운송<br>책임자</th>
                <th width="15px">클레임<br>타입</th>
                <th width="15px">클레임<br>내용</th>
                <th width="15px">패널티<br>내용</th>
                <th width="5%">배상<br>요청금</th>
                <th width="5%">지급<br>산정금</th>
                <th width="3%">진행<br>상태</th>
                <th width="5%">상세보기</th>

            </tr>
            <c:forEach var="vocList" items="${vocList}">
                <c:choose>
                    <c:when test="${vocList.complain.orderBean.driver.userNum == sessionScope.principal.userNum || sessionScope.principal.role eq'ADMIN'}">
                        <tr height="50px">
                            <td>${vocList.complain.orderBean.orderNum}</td>
                            <td>${vocList.complain.orderBean.client.userName}</td>
                            <td>${vocList.complain.orderBean.driver.userName}</td>
                            <td>${vocList.complain.complainType}</td>
                            <td>${vocList.complain.complainContent}</td>
                            <td>${vocList.penalty}</td>
                            <td>${vocList.complain.indemnity}</td>
                            <c:forEach items="${vocList.compensation}" var="compensation">
                                <td>${compensation.realIndemnity}</td>
                            </c:forEach>
                            <td>${vocList.vocProgress}</td>
                            <td><a href="/voc/detail/${vocList.vocNum}" class="inform">상세</a></td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </table>
        <p>* 진행상황-> ENROLL : 클레임 접수, DRICHK : 기사 확인, CONFIRM : 기사 승인<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            APPEAL : 기사 이의제의, CLICONFIRM : 고객사 컨펌, END : 종료</p>
        <br><br>
    </div>
</div>
<script type="text/javascript" src="/js/order.js?v=1"></script>
<jsp:include page="../layout/footer.jsp"/>