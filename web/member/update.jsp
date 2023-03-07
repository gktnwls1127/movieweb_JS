<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.MemberController" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원정보 수정</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="/assets/js/member/printOne.js"></script>

    <%
        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        MemberController memberController = new MemberController(connectionMaker);

        MemberDTO memberDTO = memberController.selectOne(id);

        pageContext.setAttribute("memberDTO", memberDTO);
    %>
    <style>
        .btn-outline-color {
            --bs-btn-color : #AAC4FF;
            --bs-btn-hover-color : #ffffff;
            --bs-btn-border-color :#AAC4FF;
            --bs-btn-focus-shadow-rgb : 25,135,84;
            --bs-btn-active-color : #fff;
            --bs-btn-hover-bg :#AAC4FF;
            --bs-btn-hover-border-color :#AAC4FF;
            --bs-btn-active-shadow : inset 0 3px 5px rgba(0, 0, 0, 0.125);
            --bs-btn-active-bg : #AAC4FF;
            --bs-btn-active-border-color : #AAC4FF;
            --bs-btn-disabled-bg : transparent;
            --bs-btn-disabled-color : #AAC4FF;
            --bs-btn-disabled-border-color : #AAC4FF;
            --bs-gradient : none;
        }
    </style>
</head>
<body>
<jsp:include page="/tools/header.jsp"/>

<div class="container">
    <div class="py-5 text-center">
        <h2>회원 정보 수정</h2>
    </div>
    <div class="container">
        <h4 class="mb-3">${memberDTO.username}님</h4>
        <hr class="my-4">
        <div class="needs-validation">
            <div class="row g-3">
                <div class="col-12">
                    <h6 class="form-label">Member Number : <b>${memberDTO.id}</b></h6>
                </div>
                <div class="col-12">
                    <h6 class="form-label">Username : <b>${memberDTO.username}</b></h6>
                </div>
                <hr class="my-4">
                <div class="col-12">
                    <label class="form-label">Nickname</label>
                    <input type="text" class="form-control" id="nickname" name="nickname" value="${memberDTO.nickname}">
                </div>
                <div class="col-12">
                    <label class="form-label">NewPassword</label>
                    <input type="password" class="form-control" id="newPassword" name="newPassword">
                </div>

                <div class="col-12">
                    <label class="form-label">OldPassword</label>
                    <input type="password" class="form-control" name="oldPassword" id="oldPassword">
                </div>
                <hr class="my-4">
                <button class="w-100 btn btn-outline-color btn-lg col-5 mb-5" onclick="updateMember(${memberDTO.id})">회원정보 수정</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
