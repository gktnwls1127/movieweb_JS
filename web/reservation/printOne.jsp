<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="controller.ReviewController" %>
<%@ page import="model.ReviewDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <%
        MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");

        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        FilmController filmController = new FilmController(connectionMaker);
        ReviewController reviewController = new ReviewController(connectionMaker);
        FilmDTO filmDTO = filmController.selectOne(id);
        ArrayList<ReviewDTO> reviewList = reviewController.selectAll(id);

        int[] numList = new int[80];

        for (int i = 1; i <= numList.length; i++){
            numList[i-1] = i;
        }

        pageContext.setAttribute("filmDTO", filmDTO);
        pageContext.setAttribute("num", numList);
        pageContext.setAttribute("reviewList", reviewList);
        pageContext.setAttribute("reviewController", reviewController);
    %>
    <title>${filmDTO.title} 예약하기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
<%--    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/hiphop5782/js@latest/cinema/hakademy-cinema.css">--%>
<%--    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/js@latest/cinema/hakademy-cinema.js"></script>--%>
<%--    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/hiphop5782/js@latest/cinema/hakademy-cinema.min.css">--%>
<%--    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/js@latest/cinema/hakademy-cinema.min.js"></script>--%>
<%--    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/hiphop5782/js@0.0.13/cinema/hacademy-cinema.css">--%>
<%--    <style>--%>
<%--        *{--%>
<%--            box-sizing: border-box;--%>
<%--        }--%>
<%--        .float-box > div{--%>
<%--            float:left;--%>
<%--            width:100%;--%>
<%--        }--%>
<%--        .float-box::after{--%>
<%--            content:"";--%>
<%--            display: block;--%>
<%--            clear:both;--%>
<%--        }--%>
<%--        .float-box > .result {--%>
<%--            padding:0.5rem;--%>
<%--        }--%>

<%--    </style>--%>
<%--    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/js@0.0.13/cinema/hacademy-cinema.js"></script>--%>
<%--    <script>--%>
<%--        window.addEventListener("load", function(){--%>
<%--            var cinema = new Hacademy.Reservation("#cinema");--%>
<%--            cinema.addChangeListener(function(seat){--%>
<%--                print(this);--%>
<%--            });--%>
<%--            print(cinema);--%>
<%--            function print(app){--%>
<%--                document.querySelector(".result").textContent = app.getQueryString();--%>
<%--            }--%>
<%--        });--%>
<%--    </script>--%>
</head>
<body onload="seat()">
<jsp:include page="/tools/header.jsp"/>
<div class="container">
    <c:set var="logIn" value="<%=logIn%>"/>
    <div class="row mb-5 text-center">
        <div class="col-md-5 themed-grid-col">
            <img src="${filmDTO.images}" class="mb-3 image-size"
                 style="width: 100%; height: 400px; object-fit: contain"/>
            <c:if test="${logIn.level eq 3}">
                <div colspan="2" class="text-center">
                    <div class="btn btn-outline-success"
                         onclick="location.href='/film/update.jsp?id=${filmDTO.id}'">수정하기
                    </div>
                    <div class="btn btn-outline-danger" onclick="deleteFilm(${filmDTO.id})">삭제하기</div>
                </div>
            </c:if>
        </div>
        <div class="col-md-7 themed-grid-col mt-3">
            <h3>${filmDTO.title}</h3>
            <p class="mb-5"><small>${filmDTO.rating}</small></p>
            <div class="text-start m-3"><span
                    style="color: blue; font-size: 48px"><b>${reviewController.calculateAverage(reviewList)}</b></span>
                <span style="font-size: 30px">/5.0</span></div>
            <p>영화 줄거리 : ${filmDTO.summary}</p>
        </div>
    </div>
    <div>
        <div class="row justify-content-center mb-3">
            <div class="col-10">
                <div class="form-floating">
                    <select class="form-select" name="theaterId" id="theaterId">
                        <option selected>관람인원을 선택해주세요.</option>
                        <c:forEach items="${num}" var="number" >
                            <option value="${number}">${number} 명</option>
                        </c:forEach>
                    </select>
                    <label for="theaterId">인원 선택</label>
                </div>
            </div>
        </div>
    </div>
    <c:if test="${logIn.level != 3}">
        <div class="row justify-content-center mb-5">
            <div class="col-10">
                <button class="btn btn-outline-primary">선택하기</button>
            </div>
        </div>
    </c:if>

<%--    <div class="float-box">--%>
<%--        <div>--%>
<%--            <form action="example.html" method="get">--%>
<%--                <div id="cinema" class="cinema-wrap" data-name="seat" >--%>
<%--                    <div class="cinema-screen">전면스크린</div>--%>
<%--                    <div class="cinema-seat-area" data-rowsize="8" data-colsize="10" data-mode="client" data-fill="auto" data-seatno="visible"></div>--%>
<%--                </div>--%>
<%--                <button class="text-end btn btn-outline-info mt-3" type="submit">선택</button>--%>
<%--            </form>--%>
<%--        </div>--%>
<%--        <h2 align="center">전송되는 데이터 형태</h2>--%>
<%--        <div class="result">--%>
<%--        </div>--%>
<%--    </div>--%>
</div>
</body>
</html>
