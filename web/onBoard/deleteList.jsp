<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.MemberDTO" %>
<%@ page import="controller.FilmController" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="controller.TheaterController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="controller.OnBoardController" %>
<%@ page import="model.OnBoardDTO" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>상영정보 삭제하기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="/assets/js/onBoard/delete.js"></script>
    <%
        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        FilmController filmController = new FilmController(connectionMaker);
        TheaterController theaterController = new TheaterController(connectionMaker);
        OnBoardController onBoardController = new OnBoardController(connectionMaker);

        ArrayList<OnBoardDTO> onBoard_list = onBoardController.selectFilmAll(id);
        FilmDTO filmDTO = filmController.selectOne(id);

        pageContext.setAttribute("filmDTO", filmDTO);
        pageContext.setAttribute("theaterController", theaterController);
        pageContext.setAttribute("onBoard_list", onBoard_list);

    %>
</head>
<body style="background-color: #EEF1FF">
<jsp:include page="/tools/header.jsp"/>

<div class="container">
    <div class="row align-items-center text-center">
        <div class="row justify-content-center">
            <div class="m-5 text-start">
                <h4>${filmDTO.title} 상영정보 삭제하기</h4>
            </div>
            <table class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">상영번호</th>
                    <th scope="col">영화 제목</th>
                    <th scope="col">극장</th>
                    <th scope="col">상영시간</th>
                    <th scope="col"></th>
                </tr>
                </thead>
                <c:forEach items="${onBoard_list}" var="onBoard">
                    <tbody>
                    <tr>
                        <th scope="row">${onBoard.id}번</th>
                        <td>${filmDTO.title}</td>
                        <td>${theaterController.selectOne(onBoard.theaterId).theaterName}</td>
                        <td>${onBoard.runningTime}</td>
                        <td><button class="btn btn-outline-danger" onclick="deleteOnBoard(${onBoard.id})">삭제</button></td>
                    </tr>
                    </tbody>
                </c:forEach>
            </table>
        </div>
    </div>
</div>
</body>
</html>
