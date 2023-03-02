let writeOnBoard = () => {
    let formData = {
        "filmId" : $('#filmId').val(),
        "theaterId" : $('#theaterId').val(),
        "runningTime" : $('#runningTime').val()
    }

    $.ajax({
        url: "/onBoard/write",
        method: "post",
        data: formData,
        success: (message) => {
            let response = JSON.parse(message);
            if (response.status == "success") {
                Swal.fire({
                    title: "성공",
                    text : "성공적으로 상영정보 작성이 완료 되었습니다.",
                    icon: "success"
                }).then(()=>{
                    location.href = '/onBoard/printList.jsp'
                })
            } else {
                Swal.fire({
                    title: "!!! ERROR !!!",
                    text: response.message,
                    icon: "error"
                }).then(() => {
                    location.reload()
                })

            }
        }
    })
}