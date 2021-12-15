<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<jsp:include page="../layout/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd_HH:mm" var="now" />
<link rel="stylesheet" type="text/css" href="/css/voc.css">


<div id="container">

    <div id="wrap">
        <h2>VOC<br>등록</h2>
        <hr>
        <form>
            <table>
                <tr>
                    <th>등록 직원</th>
                    <td>
                        <label><input type="text" class="btn-long-long" value="${sessionScope.principal.userName}" readonly></label>
                        <input type="hidden" id="adminNum" value="${sessionScope.principal.userNum}">
                    </td>
                </tr>
                <tr>
                    <th>귀책 당사자</th>
                    <td>
                        <label><input type="radio" name="role" value="AGENCY">운송사</label>
                        <label><input type="radio" name="role" value="DRIVER">지입기사</label>
                    </td>
                </tr>
                <tr>
                    <th>귀책 사유</th>
                    <td>
                        <textarea id="causes" cols="34" rows="3" placeholder="사유를 입력해주세요."></textarea>
                    </td>
                </tr>
                <tr>
                    <th>조치사항<br>(패널티)</th>
                    <td>
                        <textarea id="penalty" cols="34" rows="3" placeholder="조치사항을 입력해주세요."></textarea>
                    </td>
                </tr>
                    <th>실제<br>배상금</th>
                    <td>
                        <input type="number" class="btn-long-long" min="0" id="realIndemnity" placeholder="실제 배상금을 작성해주세요.">
                    </td>
                <tr>
                </tr>
            </table>
        </form>
        <button id="btn-save" onclick="doSave(${complain.complainNum});">등록</button>
    </div>


    <div id="list_wrap">
        <h3>클레임 정보</h3>
        <table id="complain" class="order_list" width="800px">
            <tr height="50px">
                <th width="25%">클레임 타입</th>
                <th width="50%">클레임 상세내용</th>
                <th>요청 손해배상금</th>
            </tr>
            <tr height="50px">
                <td>${complain.complainType}
                    <input type="hidden" id="complainNum" value="${complain.complainNum}">
                </td>
                <td>${complain.complainContent}</td>
                <td>${complain.indemnity} 원</td>
            </tr>
        </table>

        <h3>운송 정보</h3>
        <table class="order_list">
            <tr height="50px">
                <th width="10%">주문 번호</th>
                <th width="10%">고객사</th>
                <th width="10%">운송사</th>
                <th width="50px">출발지</th>
                <th width="50px;">도착지</th>
                <th width="10%">운임</th>
                <th width="10%">요청도착시간</th>
                <th width="10%">운송완료시간</th>
            </tr>
            <tr height="50px">
                <td>${complain.orderBean.orderNum}</td>
                <td>${complain.orderBean.client.userName}
                    <input type="hidden" id="cliNum" value="${complain.orderBean.client.userNum}">
                </td>
                <td>${complain.orderBean.driver.userName}</td>
                <td>${complain.orderBean.departure}</td>
                <td>${complain.orderBean.destination}</td>
                <td>${complain.orderBean.price} 원</td>
                <td>${complain.orderBean.requestTime}</td>
                <td>${complain.orderBean.arriveTime}</td>

            </tr>
        </table>
        <br>
    </div>
    <br><br>
</div>

<script src="/js/voc.js?v=1"></script>

<jsp:include page="../layout/footer.jsp"/>