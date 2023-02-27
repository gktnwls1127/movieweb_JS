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
        MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");
        if (logIn == null) {
            response.sendRedirect("/index.jsp");
        }

        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        MemberController memberController = new MemberController(connectionMaker);

        MemberDTO memberDTO = memberController.selectOne(id);

        pageContext.setAttribute("memberDTO", memberDTO);
    %>
</head>
<body>
<header class="p-3 mb-3 border-bottom">
    <jsp:include page="/tools/header.jsp"/>
</header>
<div class="container-fluid">
    <div class="py-5 text-center">
        <h2>회원 정보 수정</h2>
    </div>
    <div class="container">
        <div class="row g-5">
            <div class="col-md-5 col-lg-4 order-md-last align-items-center">
                <button class="btn btn-outline-success" onclick="location.href='/member/update.jsp?id=${memberDTO.id}'">
                    정보 수정
                </button>
                <button class="btn btn-outline-danger" onclick="withdrawal()">회원 탈퇴</button>
            </div>
            <div class="col-md-7 col-lg-8">
                <h4 class="mb-3">${memberDTO.username}님</h4>
                <hr class="my-4">
                <form class="needs-validation">
                    <div class="row g-3">
                        <div class="col-12">
                            <h6 class="form-label">Member Number : <b>${memberDTO.id}</b></h6>
                        </div>
                        <div class="col-12">
                            <h6 class="form-label">Username : <b>${memberDTO.username}</b></h6>
                        </div>

                        <div class="col-12">
                            <h6 class="form-label">Nickname : <b>${memberDTO.nickname}</b></h6>
                        </div>

                        <hr class="my-4">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
