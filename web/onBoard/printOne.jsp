<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.OnBoardDTO" %>
<%@ page import="controller.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <%
        MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");

        int filmId = Integer.parseInt(request.getParameter("filmId"));

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        FilmController filmController = new FilmController(connectionMaker);

        FilmDTO filmDTO = filmController.selectOne(filmId);

        MemberController memberController = new MemberController(connectionMaker);
        TheaterController theaterController = new TheaterController(connectionMaker);
        OnBoardController onBoardController = new OnBoardController(connectionMaker);

        ArrayList<OnBoardDTO> list = onBoardController.selectFilmAll(filmId);

        pageContext.setAttribute("filmDTO", filmDTO);
        pageContext.setAttribute("memberController", memberController);
        pageContext.setAttribute("theaterController", theaterController);
        pageContext.setAttribute("list", list);
    %>
    <title>
        <%=filmDTO.getTitle()%>
    </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/onBoard/printOne.css">
</head>
<body>
<jsp:include page="/tools/header.jsp"/>
<div class="container">
    <c:set var="logIn" value="<%=logIn%>"/>
    <div class="row mb-3 text-center">
        <div class="col-md-5 themed-grid-col">
            <img src="${filmDTO.images}" class="mb-3" style="width: 100%; height: 400px; object-fit: contain"/>
            <c:if test="${logIn.level eq 3}">
                <div colspan="2" class="text-center">
                    <div class="btn btn-outline-success"
                         onclick="location.href='/onBoard/updateList.jsp?id=<%=filmDTO.getId()%>'">?????? ?????? ??????
                    </div>
                    <div class="btn btn-outline-danger" onclick="location.href='/onBoard/deleteList.jsp?id=<%=filmDTO.getId()%>'">?????? ?????? ??????</div>
                </div>
            </c:if>
        </div>
        <div class="col-md-7 themed-grid-col mt-3">
            <h5>?????? ?????? : ${filmDTO.title}</h5>
            <p class="mb-5"><small>?????? ?????? : ${filmDTO.rating}</small></p>
            <p>?????? ????????? : ${filmDTO.summary}</p>
        </div>
    </div>
    <div class="row align-items-start justify-content-center m-5">
        <h5 class="mb-3"><b>${filmDTO.title} ???????????? ?????????</h5>
        <c:forEach var="list" items="${list}">
            <div class="col mb-3">
                <div class="card">
                    <h5 class="card-header">${theaterController.selectOne(list.theaterId).id}. ${theaterController.selectOne(list.theaterId).theaterName}??? <small style="color : blue"><button class="custom-btn1 btn-18">${list.runningTime}</button></small></h5>
                    <div class="card-body">
                        <h5 class="card-title">?????? : ${theaterController.selectOne(list.theaterId).theaterPlace}</h5>
                        <p class="card-text">?????? ?????? : ${theaterController.selectOne(list.theaterId).theaterNumber}</p>
                        <a href="/theater/printOne.jsp?id=${theaterController.selectOne(list.theaterId).id}"
                           class="btn btn-outline-success">????????? ??????</a>
                    </div>
                </div>
            </div>
        </c:forEach>

    </div>
</div>
</body>
</html>




















