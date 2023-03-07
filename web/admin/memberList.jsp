<%@ page import="model.MemberDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="controller.MemberController" %>
<%@ page import="connector.ConnectionMaker" %>
<%@ page import="connector.MySqlConnectioMaker" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script src="/assets/js/member/upgradeRank.js"></script>
    <script src="/assets/js/member/deleteMember.js"></script>
    <link rel="stylesheet" href="/admin/listTable.css">

    <%
        ConnectionMaker connectionMaker = new MySqlConnectioMaker();
        MemberController memberController = new MemberController(connectionMaker);
        ArrayList<MemberDTO> list = memberController.selectAll();

        pageContext.setAttribute("list", list);
    %>
</head>
<body style="background-color: #EEF1FF">
<jsp:include page="/tools/header.jsp"/>
<div class="container">
    <div class="py-3 text-start">
        <h2>회원관리</h2>
    </div>
    <c:choose>
    <c:when test="${list.isEmpty()}">
        <div class="row mb-5">
            <div class="col-6">
                <span>가입한 회원이 존재하지 않습니다.</span>
            </div>
        </div>
    </c:when>
    <c:otherwise>
    <table class="table table-stripped table-hover text-center">
        <thead>
        <tr>
            <th>회원 번호</th>
            <th>회원 아이디</th>
            <th>회원 닉네임</th>
            <th>현재 등급</th>
            <th>비고</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="member" items="${list}">
            <tr>
                <td>
                        ${member.id}
                </td>
                <td>
                        ${member.username}
                </td>
                <td>
                        ${member.nickname}
                </td>
                <td>
                        ${member.level}
                </td>
                <td>
                    <c:choose>
                        <c:when test="${member.id != 1}">
                            <button class="btn btn-outline-success"
                                    onclick="location.href='/admin/memberUpdate.jsp?id=${member.id}'">
                                등급수정
                            </button>
                            <button class="btn btn-outline-danger"
                                    onclick="deleteMember(${member.id})">
                                회원삭제
                            </button>
                        </c:when>
                        <c:otherwise>
                            기본 관리자
                        </c:otherwise>
                    </c:choose>

                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</div>
</c:otherwise>
</c:choose>
</div>
</body>
</html>
