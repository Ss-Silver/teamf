<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<jsp:include page="../layout/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/order.css">
<link rel="stylesheet" type="text/css" href="/css/complain.css">



<div id="container">
    <div id="list_wrap">
        <h2>VOC / 배상 현황</h2>
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
                <th width="15%">배상<br>요청금</th>
                <th width="15%">지급<br>산정금</th>
                <th width="15%">VOC<br>진행상태</th>
            </tr>
            <tr height="50px">
                <td>${voc.complain.complainType}
                <input type="hidden" value="${voc.vocNum}" id="vocNum"></td>
                <td>${voc.complain.complainContent}</td>
                <td>${voc.complain.indemnity}</td>
                <c:forEach items="${voc.compensation}" var="compensation">
                    <c:choose>
                        <c:when test="${empty compensation}">
                            <td>gd</td>
                        </c:when>
                        <c:when test="${compensation.realIndemnity != 0}">
                            <td>${compensation.realIndemnity}</td>
                        </c:when>
                    </c:choose>
                </c:forEach>

                <td>${voc.vocProgress}</td>
            </tr>
        </table>
        <br><br>
    </div>

    <div id="complain-wrap">
        <h2>이의제기 등록</h2>
        <hr>
        <table>
            <tr>
                <th>제목</th>
                <td>
                    <input type="text" class="btn-long-long" id="title" placeholder="제목을 입력해주세요.">
                </td>
            </tr>
            <tr>
                <th>사유</th>
                <td>
                    <textarea id="content" cols="34" rows="3" placeholder="사유를 입력해주세요."></textarea>
                </td>
            </tr>
            <tr>
                <th>변경<br>청구요청금</th>
                <td>
                    <input type="number" min=0 id="money" class="btn-long-long" placeholder="변경 손해배상 청구요청금액을 입력하세요">
                </td>
            </tr>
        </table>
        <c:forEach items="${voc.compensation}" var="compensation">
            <a href="#" class="inform" onclick="doSave(${compensation.compensationNum})">등록</a>
        </c:forEach>
    </div>

    <br><br>
</div>
<script type="text/javascript" src="/js/appeal.js?v=1"></script>
<jsp:include page="../layout/footer.jsp"/>