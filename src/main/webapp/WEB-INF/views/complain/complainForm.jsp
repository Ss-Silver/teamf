<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<link rel="stylesheet" type="text/css" href="/css/order.css">
<link rel="stylesheet" type="text/css" href="/css/complain.css">

<jsp:include page="../layout/header.jsp"/>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
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
                <td>${orderBean.orderNum}
                    <input type="hidden" id="orderNum" value="${orderBean.orderNum}">
                </td>
                <td>${orderBean.client.userName}
                    <input type="hidden" id="cliNum" value="${orderBean.client.userNum}">
                </td>
                <td>${orderBean.departure}</td>
                <td>${orderBean.destination}</td>
                <td>${orderBean.price}</td>
                <td>${orderBean.requestTime}
                </td>
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
    </div>

    <div id="complain-wrap">
        <h2>컴플레인 등록</h2>
        <hr>
            <table>
                <tr>
                    <th>컴플레인 타입</th>
                    <td>
                        <select id="complainType" class="btn-long-long" name="claimType" style="text-align:center;">
                            <option>--- 선택 ---</option>
                            <option value="OVERTIME">1. 운송 지연</option>
                            <option value="DAMAGE">2. 상품 파손</option>
                            <option value="BAD_SERVICE">3. 서비스 불량</option>
                            <option value="OTHER">4. 기타</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>클레임 사유</th>
                    <td>
                        <textarea id="complainContent" cols="34" rows="3" placeholder="사유를 입력해주세요."></textarea>
                    </td>
                </tr>
                <tr>
                    <th>손해배상<br>청구요청금</th>
                    <td>
                        <input type="number" min=0 id="indemnity" class="btn-long-long" placeholder="손해배상 청구요청금액을 입력하세요">
                    </td>
                </tr>
            </table>
        <a href="#" class="inform" onclick="doSave(${orderBean.orderNum})">컴플레인 등록</a>
    </div>
    <br><br>
</div>


<script src="/js/complain.js?v=1"></script>

<jsp:include page="../layout/footer.jsp"/>