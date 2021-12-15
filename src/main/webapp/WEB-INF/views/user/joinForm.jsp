<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<jsp:include page="../layout/header.jsp"/>
<link rel="stylesheet" type="text/css" href="/css/user.css">
<div id="container">
    <div id="wrap">
        <h2>회원<br>가입</h2>
        <hr>
        <form>
            <table>
                <tr>
                    <th>구분</th>
                    <td>
                        <label><input type="radio" name="role" value="CLIENT" checked>고객사</label>
                        <label><input type="radio" name="role" value="AGENCY">운송사</label>
                    </td>
                </tr>
                <tr>
                    <th>아이디</th>
                    <td>
                        <input type="text" id = "userId" name="id" placeholder="아이디를 입력하세요" autocomplete="userId" required oninput = "checkId()" />
                        <span class="id_ok">사용 가능</span>
                        <span class="id_already">사용 불가</span>
                    </td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td>
                        <input type="password" id="pwd1" class="btn-long" placeholder="비밀번호를 입력하세요.">
                    </td>
                </tr>
                <tr>
                    <th>비밀번호확인</th>
                    <td>
                        <input type="password" id="pwd2" class="btn-long" placeholder="비밀번호를 입력하세요.">
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <span class="pw_ok">비밀번호가 일치합니다.</span>
                        <span class="pw_no">비밀번호가 일치하지 않습니다.</span>
                    </td>
                </tr>
                <tr>
                    <th>회사명(이름)</th>
                    <td>
                        <input type="text" id="userName" class="btn-long" placeholder="이름(회사명)을 입력하세요.">
                    </td>
                </tr>
                <tr>
                    <th>전화번호</th>
                    <td>
                        <select class="tel" class="input" name="mem_phone1" id="phone1" style="text-align:center;">
                            <option>--- 선택 ---</option>
                            <option>010</option>
                            <option>011</option>
                            <option>017</option>
                            <option>019</option>
                        </select> -
                        <input type="text" class="tel" class="input" id="phone2" name="phone2"> -
                        <input type="text" class="tel" class="input" id="phone3" name="phone3">
                        <span id="ph_alert"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="hidden" id="totalMoney" value=0>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                    </td>
                </tr>
            </table>
        </form>
        <button id="btn-save" disabled>회원가입</button>
    </div>
</div>
<script>


</script>

<script src="/js/user.js?v=1"></script>

<jsp:include page="../layout/footer.jsp"/>