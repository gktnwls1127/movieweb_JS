<%@ page import="controller.TheaterController" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="model.MemberDTO" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="model.TheaterDTO" %>
<%@ page import="controller.OnBoardController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.OnBoardDTO" %>
<%@ page import="controller.FilmController" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");

        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        TheaterController theaterController = new TheaterController(connectionMaker);
        OnBoardController onBoardController = new OnBoardController(connectionMaker);
        FilmController filmController = new FilmController(connectionMaker);

        ArrayList<OnBoardDTO> list = onBoardController.selectTheaterAll(id);

        TheaterDTO theaterDTO = theaterController.selectOne(id);

        int onBoardNumber = 1;

        pageContext.setAttribute("list", list);
        pageContext.setAttribute("filmController", filmController);
        pageContext.setAttribute("theaterDTO", theaterDTO);
        pageContext.setAttribute("onBoardNumber", onBoardNumber);

    %>
    <title>${theaterDTO.theaterName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/theater/printOne.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="/assets/js/theater/delete.js"></script>
</head>
<body style="background-color: #EEF1FF">
<jsp:include page="/tools/header.jsp"/>

<jsp:include page="/theater/printList.jsp"/>
<div class="container">
    <c:set var="logIn" value="<%=logIn%>"/>
    <div class="p-4 p-md-5 mb-4 rounded text-bg-dark">
        <div class="col-md-6 px-0">
            <h1 class="display-4 fst-italic">${theaterDTO.id}. ${theaterDTO.theaterName}</h1>
            <p class="lead my-3"> ${theaterDTO.theaterPlace}</p>
            <p class="lead mb-0"> ${theaterDTO.theaterNumber}</p>
            <c:if test="${logIn.level eq 3}">
                <div colspan="2" class="mt-3">
                    <div class="btn btn-outline-success"
                         onclick="location.href='/theater/update.jsp?id=<%=theaterDTO.getId()%>'">????????????
                    </div>
                    <div class="btn btn-outline-danger" onclick="deleteTheater(${theaterDTO.id})">????????????</div>
                </div>
            </c:if>
        </div>
    </div>
    <div class="row mb-2">
        <c:forEach items="${list}" var="onboard">
            <div class="col-md-6">
                <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
                    <div class="col p-4 d-flex flex-column position-static">
                        <strong class="d-inline-block mb-2 text-primary">?????? ${onBoardNumber}???</strong>
                        <h3 class="film-title mb-2">${filmController.selectOne(onboard.filmId).title}</h3>
                        <p class="film-summary card-text mb-auto">${filmController.selectOne(onboard.filmId).summary}</p>
                        <div class="runningTime mb-2 mt-2 text-start">
                            <button class="custom-btn1 btn-18" onclick="location.href='/reservation/printOne.jsp?id=${onboard.filmId}'">${onboard.runningTime}</button>
                        </div>
                    </div>
                    <div class="col-auto d-none d-lg-block">
                        <img class="bd-placeholder-img" width="200"
                             src="${filmController.selectOne(onboard.filmId).images}"/>
                    </div>
                </div>
            </div>
            <c:set var="onBoardNumber" value="${onBoardNumber+1}"></c:set>
        </c:forEach>
    </div>
</div>
</body>
</html>
