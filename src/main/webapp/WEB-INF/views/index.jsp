<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
            pageEncoding="UTF-8" %>
<jsp:include page="layout/header.jsp"/>


    <div id="container">

        <c:choose>
            <c:when test="${empty sessionScope.principal}">
                <h1 id="welcome">우측 상단 로그인 혹은 회원가입을 눌러주세요.</h1>
            </c:when>
            <c:otherwise>
                <h1 id="welcome">우측 상단 메뉴를 선택해주세요. </h1>
            </c:otherwise>
        </c:choose>


    </div>



<jsp:include page="layout/footer.jsp"/>