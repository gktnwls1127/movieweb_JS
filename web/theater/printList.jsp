<%@ page import="model.MemberDTO" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="controller.TheaterController" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.TheaterDTO" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
  <%
    MemberDTO logIn = (MemberDTO) session.getAttribute("logIn");

    ConnectionMaker connectionMaker = new MySqlConnectioMaker();
    TheaterController theaterController = new TheaterController(connectionMaker);

    ArrayList<TheaterDTO> list = theaterController.selectAll();

    pageContext.setAttribute("list", list); //page 단위의 변수를 저장
  %>
  <title>극장 목록</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
          integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
  <style>
    .theater {
      color: #EEF1FF;
      --bs-nav-link-color : #B1B2FF;
      --bs-nav-link-hover-color : #B1B2FF ;
      word-spacing: 10px;
      text-decoration: none;
      line-height: 30px;
    }
  </style>
</head>
<body>
<c:set value="<%=logIn%>" var="logIn"/>
<div class="container">
  <div class="row align-items-center justify-content-center">
    <div class="p-4 p-md-5 mb-4 rounded" style="width: 1300px; font-size: 15px; height: 400px; background-color: #B1B2FF; border: 15px; padding: 30px">
      <c:forEach var="t" items="${list}">
        <a class = "theater" href="/theater/printOne.jsp?id=${t.id}">${t.theaterName} | </a>
      </c:forEach>
    </div>
<c:if test="${logIn.level == 3}">
  <div class="row">
    <div class="col-12 text-end">
      <span class="btn btn-outline-info mb-5" onclick="location.href='/theater/write.jsp'">극장 추가하기</span>
    </div>
  </div>
</c:if>
  </div>
</div>

<%--<div class="container">--%>
<%--  <div class="row vh-100 align-items-center">--%>
<%--    <c:choose>--%>
<%--      <c:when test="${list.isEmpty()}">--%>
<%--        <div class="row">--%>
<%--          <div class="col-6">--%>
<%--            <span>아직 등록된 영화관이 존재하지 않습니다.</span>--%>
<%--          </div>--%>
<%--        </div>--%>
<%--      </c:when>--%>
<%--      <c:otherwise>--%>
<%--        <div class="row justify-content-center" style=" width: 1000px; padding: 30px; margin: auto;">--%>
<%--        <c:forEach var="t" items="${list}">--%>
<%--            <div class="col-10 mb-3">--%>
<%--              <div class="card">--%>
<%--                <h5 class="card-header">${t.id}. ${t.theaterName}</h5>--%>
<%--                <div class="card-body">--%>
<%--                  <h5 class="card-title">위치 : ${t.theaterPlace}</h5>--%>
<%--                  <p class="card-text">전화 번호 : ${t.theaterNumber}</p>--%>
<%--                  <a href="/theater/printOne.jsp?id=${t.id}" class="btn btn-outline-success">영화관 이동</a>--%>
<%--                </div>--%>
<%--              </div>--%>
<%--            </div>--%>
<%--        </c:forEach>--%>
<%--        </div>--%>
<%--      </c:otherwise>--%>
<%--    </c:choose>--%>

<%--    <c:if test="${logIn.level == 3}">--%>
<%--      <div class="row">--%>
<%--        <div class="col-11 text-end">--%>
<%--          <span class="btn btn-outline-info mb-5" onclick="location.href='/theater/write.jsp'">극장 추가하기</span>--%>
<%--        </div>--%>
<%--      </div>--%>
<%--    </c:if>--%>
<%--  </div>--%>
<%--</div>--%>
</body>
</html>















