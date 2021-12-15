<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<jsp:include page="../layout/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="/css/order.css">


<div id="container">
    <div id="list_wrap">
        <h2>VOC 리스트</h2>
        <hr>
        <table class="order_list">
            <tr height="50px">
                <th width="5%">Voc<br>번호</th>
                <th width="5%">주문<br>번호</th>
                <th width="10%">고객사</th>
                <th width="10%">책임자</th>
                <th width="15px">귀책 내용</th>
                <th width="15px">패널티 내용</th>
                <th width="5%">기사<br>확인여부</th>
                <th width="5%">이의<br>제기여부</th>
                <th width="5%">배상<br>요청금</th>
                <th width="5%">지급<br>배상금</th>
                <th width="3%">진행<br>상황</th>
                <th width="5%">상세보기</th>


            </tr>
            <c:forEach var="vocList" items="${vocList}">
                <tr height="50px">
                    <td>${vocList.vocNum}</td>
                    <td>${vocList.complain.orderBean.orderNum}</td>
                    <td>${vocList.complain.orderBean.client.userName}</td>
                    <td>${vocList.complain.orderBean.driver.userName}</td>
                    <td>${vocList.causes}</td>
                    <td>${vocList.penalty}</td>
                    <c:choose>
                        <c:when test="${empty vocList.chkDriver}">
                            <td> X </td>
                        </c:when>
                        <c:when test="${vocList.chkDriver}">
                            <td> O </td>
                        </c:when>
                    </c:choose>
                    <c:choose>
                        <c:when test="${empty vocList.appeal}">
                            <td> X </td>
                        </c:when>
                        <c:when test="${vocList.appeal}">
                            <td> O </td>
                        </c:when>
                    </c:choose>
                    <td>${vocList.complain.indemnity}</td>
                    <c:forEach items="${vocList.compensation}" var="compensation">
                        <c:choose>
                            <c:when test="${empty compensation}">
                                <td>gd</td>
                            </c:when>
                            <c:when test="${compensation.realIndemnity != 0}">
                                <td>${compensation.realIndemnity}</td>
                            </c:when>
                        </c:choose>

                    </c:forEach>
                    <td>${vocList.vocProgress}</td>
                    <td><a href="/complain/detail/${complainList.complainNum}" class="inform">상세</a></td>
                </tr>

            </c:forEach>
        </table>
        <br><br>
    </div>
</div>
<script type="text/javascript" src="/js/order.js?v=1"></script>
<jsp:include page="../layout/footer.jsp"/>