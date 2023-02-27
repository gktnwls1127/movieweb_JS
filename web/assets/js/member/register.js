let result = false;
function validateUsername(username){
    var data = {
        "username": username
    };

    if (username == null) {
        Swal.fire({title: '입력 오류', text: '아이디를 입력해주세요'});
        return false;
    } else {
        if (username.length >= 5) {
            return true;
        }
        $.ajax({
            url: "/user/validate",
            type: "get",
            data: data,
            success: function (message) {
                let jsonResult = JSON.parse(message)

                if (!jsonResult.result) {
                    Swal.fire({title: '실패', text: jsonResult.message});
                }
            }
        });
    }

}

function validatePassword(password){
    if (password == null) {
        Swal.fire({title: '입력 오류', text: '비밀번호를 입력해주세요'});
        return false;
    }
    if (password.includes('!')){
        return true;
    }
    return false;
}

function validateInput(){
    let username = document.getElementById("username");
    let password = document.getElementById("password");

    result = validateUsername(username.value) && validatePassword(password.value);

    if (result){
        document.forms[0].submit(); // 해당 문서의 form 태그중 0번째를 제출
    } else {
        Swal.fire({title : "!!! 오류 !!!", text: "잘못 입력하셨습니다.", icon : 'error'});
    }
}