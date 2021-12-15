<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<jsp:include page="../layout/header.jsp"/>
<link rel="stylesheet" type="text/css" href="/css/user.css">
<div id="container">
    <div id="wrap">
        <form>
            <table>
                <th>아이디</th>
                    <td>
                        <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요.">
                    </td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td>
                        <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요.">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">

                    </td>
                </tr>
            </table>
        </form>
        <button id="btn-login">로그인</button>
    </div>
</div>
<script src="/js/user.js?v=1"></script>
<jsp:include page="../layout/footer.jsp"/>