<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
    <script src="/assets/js/member/register.js"></script>
</head>
<body style="background-color: #EEF1FF;">
<div class="container-fluid">
    <div class="row vh-100 align-items-center text-center">
        <div class="row justify-content-center">
            <div class="col-3 mb-3">
                <h1>회원가입</h1>
            </div>
                <div class="row justify-content-center mb-2">
                    <div class="col-6">
                        <div class="form-floating">
                            <input type="text" id="username" name="username" class="form-control" placeholder="아이디">
                            <label for="username">아이디</label>
                        </div>
                        <div class="mt-2 usernameCheck"></div>
                    </div>
                </div>
                <div class="row justify-content-center mb-2">
                    <div class="col-6">
                        <div class="form-floating">
                            <input type="password" id="password" name="password" class="form-control" placeholder="비밀번호">
                            <label for="username">비밀번호</label>
                        </div>
                        <div class="mt-2 pwCheck"></div>
                    </div>
                </div>
                <div class="row justify-content-center mb-2">
                    <div class="col-6">
                        <div class="form-floating">
                            <input type="text" id="nickname" name="nickname" class="form-control" placeholder="닉네임">
                            <label for="username">닉네임</label>
                        </div>
                        <div class="mt-2 nickCheck"></div>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <button type="submit" class="btn btn-outline-primary col-6 m-1" onclick="validateInput()">회원가입</button>
                </div>
        </div>
    </div>
</div>
</body>
</html>
