
let withdrawal = () => {
    let temp = new URLSearchParams(window.location.search).get("id");
    let delData = {
        "id" : temp
    };

    $.ajax({
        url: "/member/withdrawal",
        type : "get",
        data : delData,
        success : function (message){
            let result = JSON.parse(message);
            if (result.status == 'success'){
                Swal.fire({
                    title: '회원탈퇴',
                    text: "정말로 회원탈퇴 하시겠습니까?",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes'
                }).then((result) => {
                    if (result.isConfirmed) {
                        Swal.fire(
                            '회원 탈퇴 성공!',
                            '성공적으로 탈퇴되었습니다.',
                            'success',
                        ).then(()=> {
                            location.href = "/index.jsp";
                        })
                    } else {
                        location.href="/member/printOne.jsp?id=" + temp
                    }
                })
            } else if (result.status = 'admin' ){
                Swal.fire({title: "탈퇴 불가", icon: "error", text: "기본 관리자는 탈퇴가 불가능합니다.", timer: 3000}).then(() => {
                    location.href = "/member/printOne.jsp?id="+ temp;
                })
            } else {
                Swal.fire({title:"회원 탈퇴 실패", icon: "error", text: "계정 정보를 다시 확인해주세요.", timer: 3000})
            }
        }
    });
}