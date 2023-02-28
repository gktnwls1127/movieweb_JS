let result = false;

function validateUsername(username) {
    let usernameResult = false;
    let data = {
        "username": username
    };

    let check_username = RegExp(/^[a-zA-Z0-9]{5,10}$/); // 아이디 유효성 검사 (영문 및 숫자 5-10글자)

    // 아이디 공백 확인
    if (username == "" || username == null) {
        $('.usernameCheck').html('아이디를 입력해주세요.').addClass("text-start").css("color", "red");
        $('#username').focus();
        usernameResult = false;

    } else if (!check_username.test(username)) { //유효성 검사
        $('.usernameCheck').html('영문 및 숫자만 5-10자리까지 입력해주세요.').addClass("text-start").css("color", "red");
        $('#username').val("");
        $('#username').focus();
        usernameResult = false;
    }

    else {
        $.ajax({
            url: "/member/validate",
            type: "get",
            data: data,
            async: false, // 비동기 값을 동기로 변경하여 return 값 얻기
            success: function (message) {
                let jsonResult = JSON.parse(message);
                if (!jsonResult.result) {
                    usernameResult =  false;
                    $('.usernameCheck').html(jsonResult.message).addClass("text-start").css("color", "red");
                }
                $('.usernameCheck').html("사용가능한 아이디입니다.").addClass("text-start").css("color", "blue");
                usernameResult = true;
            }
        });

    }
    return usernameResult;

}

function validatePassword(password) {
    if (password == "" || password == null) {
        $('.pwCheck').html('비밀번호를 입력해주세요.').addClass("text-start").css("color", "red");
        $('#password').focus();
        return false;

    } else if (password.includes('!')) {
        return true;
    } else {
        $('.pwCheck').html('!를 포함한 비밀번호를 해주세요').addClass("text-start").css("color", "red");
        $('#password').focus();
        return false;
    }

}

function validateInput() {
    let username = $('#username').val();
    let password = $('#password').val();
    let nickname = $('#nickname').val();

    // 닉네임 공백 체크
    if (nickname == "" || nickname == null) {
        $('.nickCheck').html('닉네임을 입력해주세요.').addClass("text-start").css("color", "red");
        $('#nickname').focus();
        result = false;
    }

    result = validateUsername(username) && validatePassword(password)
    console.log(validateUsername(username));
    console.log(validatePassword(password));
    if (result) {
        registerInput()
    }
}

function registerInput() {
    let data = {
        "username": $('#username').val(),
        "password": $('#password').val(),
        "nickname": $('#nickname').val()
    };

    $.ajax({
        url: "/member/register",
        type: "post",
        data: data,
        success: function (message) {
            let result = JSON.parse(message)
            if (result.result) {
                Swal.fire({title: "회원가입 성공", icon: "success", text: "성공적으로 회원가입되었습니다."}).then(() => {
                    location.href = '/index.jsp'
                })
            }
        }
    });
}