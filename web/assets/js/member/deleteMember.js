function deleteMember(id) {
    let Data = {
        "id": id,
    }

    Swal.fire({
        title: '회원 삭제',
        text: "정말로 회원을 삭제하시겠습니까? 하시겠습니까?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes'
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: "/admin/delete",
                method: "get",
                data: Data,
                success: (message) => {
                    let response = JSON.parse(message);
                    if (response.status == 'success') {
                        Swal.fire({text: "성공적으로 삭제 되었습니다.", title: "삭제 완료", icon: "success"}).then(() => {
                            location.href = '/admin/memberList.jsp';
                        })
                    } else {
                        Swal.fire({text: "오류가 발생하였습니다.", title: "!!! ERROR !!!"}).then(() => {
                            location.reload();
                        })
                    }

                }
            })
        } else {
            location.reload();
        }
    })


}