<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.FilmController" %>
<%@ page import="model.FilmDTO" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page import="controller.ReviewController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.ReviewDTO" %>
<%@ page import="controller.MemberController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <%
        MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");

        int id = Integer.parseInt(request.getParameter("id"));

        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        FilmController filmController = new FilmController(connectionMaker);

        FilmDTO filmDTO = filmController.selectOne(id);

        MemberController memberController = new MemberController(connectionMaker);

        ReviewController reviewController = new ReviewController(connectionMaker);
        ArrayList<ReviewDTO> reviewList = reviewController.selectAll(id);

        ArrayList<ReviewDTO> criticList = new ArrayList<>();
        ArrayList<ReviewDTO> generalList = new ArrayList<>();


        for (ReviewDTO review : reviewList) {
            if (memberController.selectOne(review.getWriterId()).getLevel() == 2) {
                criticList.add(review);
            } else {
                generalList.add(review);
            }
        }

        pageContext.setAttribute("filmDTO", filmDTO);
        pageContext.setAttribute("reviewList", reviewList);
        pageContext.setAttribute("criticList", criticList);
        pageContext.setAttribute("generalList", generalList);
        pageContext.setAttribute("memberController", memberController);
        pageContext.setAttribute("reviewController", reviewController);
    %>

    <script>
        function nwindow(reviewId, filmId) {
            window.name = "review";
            var url = "/review/update.jsp?id=" + reviewId + "&filmId=" + filmId;
            window.open(url, "", "width=600, height=400, left=200p")
        }
    </script>
    <title>
        <%=filmDTO.getTitle()%>
    </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/film/printOne.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="/assets/js/film/delete.js"></script>
    <script src="/assets/js/review/reviewUtil.js"></script>
</head>
<body>
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
                         onclick="location.href='/film/update.jsp?id=<%=filmDTO.getId()%>'">????????????
                    </div>
                    <div class="btn btn-outline-danger" onclick="deleteFilm(<%=filmDTO.getId()%>)">????????????</div>
                </div>
            </c:if>
        </div>
        <div class="col-md-7 themed-grid-col mt-3">
            <h3>${filmDTO.title}</h3>
            <p class="mb-5"><small>${filmDTO.rating}</small></p>
            <div class="text-start m-3"><span
                    style="color: blue; font-size: 48px"><b>${reviewController.calculateAverage(reviewList)}</b></span>
                <span style="font-size: 30px">/5.0</span></div>
            <p>?????? ????????? : ${filmDTO.summary}</p>
        </div>
    </div>

    <c:if test="${logIn.level != 3 && reviewController.validateReview(filmDTO.id, logIn.id)}">
        <div class="text-center">
            <hr>
            <h4>?????? ??????</h4>
            <div class="star-rating space-x-4 mx-auto mb-5">
                <input type="radio" id="5-stars" name="score" value="5"/>
                <label for="5-stars" class="star pr-4">???</label>
                <input type="radio" id="4-stars" name="score" value="4"/>
                <label for="4-stars" class="star">???</label>
                <input type="radio" id="3-stars" name="score" value="3"/>
                <label for="3-stars" class="star">???</label>
                <input type="radio" id="2-stars" name="score" value="2"/>
                <label for="2-stars" class="star">???</label>
                <input type="radio" id="1-star" name="score" value="1"/>
                <label for="1-star" class="star">???</label>
            </div>
            <div>
                <c:if test="${logIn.level eq 2}">
                    <input type="text" name="review" class="form-control mb-3" placeholder="????????? ??????????????????.">
                </c:if>
            </div>
            <button class="btn btn-outline-primary mb-3" onclick="writeReview()">????????????</button>
            <hr class="mb-5">
        </div>
    </c:if>

    <div class="row align-items-start vh-100 justify-content-center">
        <div class="tabs">
            <input id="all" type="radio" name="tab_item" checked>
            <label class="tab_item" for="all">?????? ??????</label>
            <input id="general" type="radio" name="tab_item">
            <label class="tab_item" for="general">???????????? ??????</label>
            <input id="critic" type="radio" name="tab_item">
            <label class="tab_item" for="critic">????????? ??????</label>

            <div class="tab_content row align-items-start justify-content-center" id="all_content">
                <ul>
                    <c:choose>
                        <c:when test="${empty reviewList}">
                            <h6>?????? ????????? ????????? ???????????? ????????????.</h6>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${reviewList}" var="review">
                                <li class="row row-cols-6 mt-3 mb-3">
                                    <div class="col">${memberController.selectOne(review.writerId).nickname}
                                        <div class="star-ratings">
                                            <div class="star-ratings-fill space-x-2 text-lg"
                                                 style="width: ${review.score*20}%">
                                                <span>???</span><span>???</span><span>???</span><span>???</span><span>???</span>
                                            </div>
                                            <div class="star-ratings-base space-x-2 text-lg">
                                                <span>???</span><span>???</span><span>???</span><span>???</span><span>???</span>
                                            </div>
                                        </div>
                                    </div>
                                    <h5><b>${review.score}???</b></h5>
                                    <c:if test="${memberController.selectOne(review.writerId).level != 2 && review.review == null}">
                                    </c:if>
                                    <div class="col-6">${review.review}</div>
                                    <c:if test="${review.writerId eq logIn.id}">
                                        <div class="col text-end">
                                            <button class="btn btn-outline-success"
                                                    onclick="location.href='/review/update.jsp?id=${review.id}'">??????
                                            </button>
                                            <button class="btn btn-outline-danger" onclick="deleteReview(${review.id})">
                                                ??????
                                            </button>
                                        </div>
                                    </c:if>
                                </li>
                                <hr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            <div class="tab_content row align-items-start justify-content-center" id="general_content">
                <ul>
                    <c:choose>
                        <c:when test="${empty generalList}">
                            <h6>?????? ????????? ???????????? ????????? ???????????? ????????????.</h6>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${generalList}" var="review">
                                <li class="row row-cols-6 mt-3 mb-3">
                                    <div class="col">${memberController.selectOne(review.writerId).nickname}
                                        <div class="star-ratings">
                                            <div class="star-ratings-fill space-x-2 text-lg"
                                                 style="width: ${review.score*20}%">
                                                <span>???</span><span>???</span><span>???</span><span>???</span><span>???</span>
                                            </div>
                                            <div class="star-ratings-base space-x-2 text-lg">
                                                <span>???</span><span>???</span><span>???</span><span>???</span><span>???</span>
                                            </div>
                                        </div>
                                    </div>
                                    <h5><b>${review.score}???</b></h5>
                                    <div class="col-6"></div>
                                    <c:if test="${review.writerId eq logIn.id}">
                                        <div class="col text-end">
                                            <button class="btn btn-outline-success"
                                                    onclick="location.href='/review/update.jsp?id=${review.id}'">??????
                                            </button>
                                            <button class="btn btn-outline-danger" onclick="deleteReview(${review.id})">
                                                ??????
                                            </button>
                                        </div>
                                    </c:if>
                                </li>
                                <hr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            <div class="tab_content row align-items-start justify-content-center" id="critic_content">
                <ul>
                    <c:choose>
                        <c:when test="${empty criticList}">
                            <h6>?????? ????????? ????????? ????????? ???????????? ????????????.</h6>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${criticList}" var="review">
                                <li class="row row-cols-6 mt-3 mb-3">
                                    <div class="col">${memberController.selectOne(review.writerId).nickname}
                                        <div class="star-ratings">
                                            <div class="star-ratings-fill space-x-2 text-lg"
                                                 style="width: ${review.score*20}%">
                                                <span>???</span><span>???</span><span>???</span><span>???</span><span>???</span>
                                            </div>
                                            <div class="star-ratings-base space-x-2 text-lg">
                                                <span>???</span><span>???</span><span>???</span><span>???</span><span>???</span>
                                            </div>
                                        </div>
                                    </div>
                                    <h5><b>${review.score}???</b></h5>
                                    <div class="col-6">${review.review}</div>
                                    <c:if test="${review.writerId eq logIn.id}">
                                        <div class="col text-end">
                                            <button class="btn btn-outline-success"
                                                    onclick="location.href='/review/update.jsp?id=${review.id}'">??????
                                            </button>
                                            <button class="btn btn-outline-danger" onclick="deleteReview(${review.id})">
                                                ??????
                                            </button>
                                        </div>
                                    </c:if>
                                </li>
                                <hr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>




















