<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<link rel="stylesheet" type="text/css" href="/css/order.css">

<jsp:include page="../layout/header.jsp"/>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
<div id="container">
    <div id="wrap">
        <h2>오더<br>등록</h2>
        <hr>
        <form>
            <table>
                <tr>
                    <th>주문자</th>
                    <td>
                        <label><input type="text" class="btn-long-long" value="${sessionScope.principal.userName}" readonly></label>
                        <input type="hidden" id="clientNum" value="${sessionScope.principal.userNum}">
                    </td>
                </tr>
                <tr>
                    <th>출발지</th>
                    <td>
                        <input type="text" id="departure" class="btn-long-long" placeholder="출발지를 입력하세요.">
                    </td>
                </tr>
                <tr>
                    <th>도착지</th>
                    <td>
                        <input type="text" id="destination" class="btn-long-long" placeholder="도착지를 입력하세요.">
                    </td>
                </tr>
                <tr>
                    <th>도착요청시간</th>
                    <td>
                        <input type="date" id="date" value="${today}" min="${today}">
                        <input type="time" id="time">
                    </td>
                </tr>
                <tr>
                    <th>운임(fare)</th>
                    <td>
                        <input type="number" id="price" class="btn-long-long" placeholder="운임을 입력하세요.">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                    </td>
                </tr>
            </table>
        </form>
        <button id="btn-save">등록</button>
    </div>
</div>


<script src="/js/order.js?v=1"></script>

<jsp:include page="../layout/footer.jsp"/>