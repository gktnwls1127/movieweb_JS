<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="controller.FilmController" %>
<%@ page import="controller.TheaterController" %>
<%@ page import="model.TheaterDTO" %>
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
    <script src="/assets/js/theater/update.js"></script>

    <%
        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        TheaterController theaterController = new TheaterController(connectionMaker);

        TheaterDTO theaterDTO = theaterController.selectOne(id);

        pageContext.setAttribute("theaterDTO", theaterDTO);
    %>
    <title>${theaterDTO.theaterName}영화관 수정하기</title>
</head>
<body style="background-color: #EEF1FF">
<jsp:include page="/tools/header.jsp"/>

<div class="container">
    <div class="row align-items-center text-center">
        <div class="row justify-content-center">
            <div class="m-5 text-start">
                <h2>극장 등록하기</h2>
            </div>
            <div class="row justify-content-center mb-3">
                <div class="col-10">
                    <div class="form-floating">
                        <input id="theaterId" class="form-control" value="${theaterDTO.id}" readonly>
                        <label for="theaterId">극장번호</label>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center mb-3">
                <div class="col-10">
                    <div class="form-floating">
                        <input id="theaterName" type="text" name="theaterName" class="form-control"
                               value="${theaterDTO.theaterName}">
                        <label for="theaterName">극장이름</label>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center mb-3">
                <div class="col-10">
                    <div class="form-floating">
                        <input id="theaterPlace" type="text" name="theaterPlace" class="form-control"
                               value="${theaterDTO.theaterPlace}">
                        <label for="theaterPlace">극장 위치</label>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center mb-3">
                <div class="col-10">
                    <div class="form-floating">
                        <input id="theaterNumber" type="text" name="theaterNumber" class="form-control"
                               value="${theaterDTO.theaterNumber}">
                        <label for="theaterNumber">극장 전화번호</label>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-10">
                    <button class="btn btn-outline-primary" onclick="updateTheater()">작성하기</button>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
