<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<jsp:include page="../layout/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/order.css">


<div id="container">
    <div id="list_wrap">
        <h2>전체 상세 현황</h2>
        <hr>
        <h3>오더 정보</h3>
        <table class="order_list">
            <tr height="50px">
                <th width="10%">오더<br>번호</th>
                <th width="10%">고객사</th>
                <th width="10%">운송<br>담당자</th>
                <th width="70px">출발지</th>
                <th width="70px;">도착지</th>
                <th width="10%">운임</th>
                <th width="15%">요청<br>도착시간</th>
                <th width="15%">운송<br>완료시간</th>
                <th width="10%">진행<br>상태</th>

            </tr>
            <tr height="50px">
                <td>${voc.complain.orderBean.orderNum}</td>
                <td>${voc.complain.orderBean.client.userName}</td>
                <td>${voc.complain.orderBean.driver.userName}</td>
                <td>${voc.complain.orderBean.departure}</td>
                <td>${voc.complain.orderBean.destination}</td>
                <td>${voc.complain.orderBean.price}</td>
                <td>${voc.complain.orderBean.requestTime}</td>
                <td>${voc.complain.orderBean.arriveTime}</td>
                <td>${voc.complain.orderBean.progress}</td>
            </tr>
        </table>
        <h3>VOC / 클레임 정보</h3>
        <table class="order_list">
            <tr height="50px">
                <th width="10%">클레임<br>타입</th>
                <th width="10%">클레임<br>내용</th>
                <th width="15%">VOC<br>진행상태</th>
            </tr>
            <tr height="50px">
                <td>${voc.complain.complainType}</td>
                <td>${voc.complain.complainContent}</td>

                <td>${voc.vocProgress}</td>
            </tr>
        </table>
        <h3>이의제기 정보</h3>
        <table class="order_list">
            <tr height="50px">
                <th width="10%">제목</th>
                <th width="10%">내용</th>
                <th width="15%">배상<br>요청금</th>
                <th width="15%">이전<br>산정금</th>
                <th width="15%">변경<br>요청금</th>
            </tr>
                <c:forEach items="${voc.compensation}" var="compensation">
                    <c:forEach items="${compensation.appeal}" var="appeal">
            <tr height="50px">

                        <td>${appeal.title}</td>
                        <td>${appeal.content}</td>
                        <td>${voc.complain.indemnity} 원</td>
                        <td>${appeal.past} 원</td>
                        <td>${appeal.renew} 원</td>
            </tr>
                    </c:forEach>
                </c:forEach>
        </table>
        <br><br>
        <c:choose>
            <c:when test="${sessionScope.principal.role eq'DRIVER'}">
                <c:choose>
                    <c:when test="${voc.vocProgress eq'ENROLL'}">
                        <a href="#" class="inform" onclick="chkDriver(${voc.vocNum})">기사 확인</a>
                    </c:when>
                    <c:when test="${voc.vocProgress eq'DRICHK' || voc.vocProgress eq'CLIAPPEAL'}">
                        <c:forEach items="${voc.compensation}" var="compensation">
                            <a href="#" class="inform" onclick="confirm(${voc.vocNum}, ${compensation.compensationNum})">기사 승인</a>
                            <br>
                            <a href="/appeal/form/${voc.vocNum}" class="inform">이의 제기</a>
                        </c:forEach>
                    </c:when>
                    <c:when test="${voc.vocProgress eq'DRIAPPEAL' || voc.vocProgress eq'END'}">
                    </c:when>
                </c:choose>
            </c:when>
            <c:when test="${sessionScope.principal.role eq'CLIENT'}">
                <c:choose>
                    <c:when test="${voc.vocProgress eq'ENROLL'}"></c:when>
                    <c:when test="${voc.vocProgress eq'DRICHK'|| voc.vocProgress eq'CLIAPPEAL'}"></c:when>
                    <c:when test="${voc.vocProgress eq'DRIAPPEAL'}">
                        <c:forEach items="${voc.compensation}" var="compensation">
                            <a href="#" class="inform" onclick="confirm(${voc.vocNum}, ${compensation.compensationNum})">고객사 승인</a>
                            <br>
                            <a href="/appeal/form/${voc.vocNum}" class="inform">이의 제기</a>
                        </c:forEach>
                    </c:when>
                    <c:when test="${voc.vocProgress eq'END'}"></c:when>
                </c:choose>
            </c:when>
            <c:otherwise></c:otherwise>
        </c:choose>
    </div>
    <br><br>
</div>
<script type="text/javascript" src="/js/voc.js?v=1"></script>
<jsp:include page="../layout/footer.jsp"/>