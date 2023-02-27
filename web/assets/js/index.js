let auth = () => {
    let username = $('#username').val();
    let password = $('#password').val();

    let data = {
        "username" : username,
        "password" : password
    };

    $.ajax({
        url: "/member/auth",
        type : "post",
        data : data,
        success : function (message){
            let result = JSON.parse(message);
            if (result.result == 'success'){
                Swal.fire({title:"로그인 성공", icon: "success", showConfirmButton: false, timer: 2000}).then(() => {
                    location.href = "/index.jsp";
                })
            } else {
                Swal.fire({title:"로그인 실패", icon : "error", text: "계정 정보를 다시 확인해주세요.", timer: 2000})
            }
        }
    });
}

let logout = () => {
    $.ajax({
        url: "/member/logout",
        type : "post",
        data : data,
        success : function (message){
            let result = JSON.parse(message);
            if (result.result == 'success'){
                Swal.fire({title:"로그인 성공", icon: "success", showConfirmButton: false, timer: 2000}).then(() => {
                    location.href = "/index.jsp";
                })
            } else {
                Swal.fire({title:"로그인 실패", icon : "error", text: "계정 정보를 다시 확인해주세요.", timer: 2000})
            }
        }
    });
}
