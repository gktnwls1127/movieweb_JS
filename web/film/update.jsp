<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="controller.FilmController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="/assets/js/film/update.js"></script>

    <%
        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        FilmController filmController = new FilmController(connectionMaker);

        FilmDTO filmDTO = filmController.selectOne(id);

        pageContext.setAttribute("filmDTO", filmDTO);
    %>
    <title>${filmDTO.title} 영화 수정하기</title>
</head>
<body>
<header class="p-3 mb-3 border-bottom">
    <jsp:include page="/tools/header.jsp"/>
</header>
<div class="container">
    <div class="row align-items-center justify-content-center text-end">
        <div class="m-5 text-start">
            <h2>영화 수정하기</h2>
        </div>
        <img src="${filmDTO.images}" style="width: 300px; height: 400px; margin-bottom: 20px">
        <div class="row justify-content-center mb-3">
            <div class="col-10">
                <div class="form-floating">
                    <input id="id" type="text" value="${filmDTO.id}" class="form-control" readonly>
                    <label for="id">영화번호</label>
                </div>
            </div>
        </div>
        <div class="row justify-content-center mb-3">
            <div class="col-10">
                <div class="form-floating">
                    <input id="title" type="text" name="title" class="form-control"
                           value="${filmDTO.title}">
                    <label for="title">영화제목</label>
                </div>
            </div>
        </div>
        <div class="row justify-content-center mb-3">
            <div class="col-10">
                <div class="form-floating">
                    <input id="rating" type="text" name="rating" class="form-control"
                           value="${filmDTO.rating}">
                    <label for="rating">영화등급</label>
                </div>
            </div>
        </div>
        <div class="row justify-content-center mb-3">
            <div class="col-10">
                <div class="form-floating">
                            <textarea id="summary" type="text" name="summary" class="form-control"
                                      style="height: 200px">${filmDTO.summary}</textarea>
                    <label for="summary">영화 줄거리</label>
                </div>
            </div>
        </div>
        <div class="row justify-content-center mb-4">
            <div class="col-10">
                <input type="file" name="images" id="images"/>
            </div>
        </div>
        <div class="row justify-content-center mb-5">
            <div class="col-10">
                <button class="btn btn-outline-primary" onclick="updateFilm()">수정하기</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
