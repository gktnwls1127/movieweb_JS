<%@ page import="model.MemberDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>등업신청</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="/assets/js/member/promote.js"></script>
    <%
        MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");

        String level = "";

        if (logIn.getLevel() == 1) {
            level = "일반회원";
        } else if (logIn.getLevel() == 2) {
            level = "평론가";
        } else {
            level = "관리자";
        }

        pageContext.setAttribute("level", level);
    %>


</head>
<body style="background-color: #EEF1FF">
<jsp:include page="/tools/header.jsp"/>
<div class="container">
    <div class="row align-items-center text-center">
        <div class="row justify-content-center">
            <div class="m-5 text-start">
                <h2>등업 신청하기</h2>
            </div>
            <div class="row justify-content-center mb-3">
                <div class="col-10">
                    <div class="form-floating">
                        <input class="form-control" type="text" value="${level}" id="current_level" disabled>
                        <label for="current_level">현재 등급</label>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center mb-3">
                <div class="col-10">
                    <div class="form-floating">
                        <select class="form-select" name="level" id="level">
                            <option selected>신청하고자 하는 등급 메뉴를 골라주세요</option>
                            <option value=1>일반회원</option>
                            <option value=2>평론가</option>
                            <option value=3>관리자</option>
                        </select>
                        <label for="level">등급 선택</label>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-10">
                    <button class="btn btn-outline-primary" onclick="promote()">신청하기</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
