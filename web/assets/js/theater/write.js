let writeTheater = () => {
    let formData = {
        "theaterName" : $('#theaterName').val(),
        "theaterPlace" : $('#theaterPlace').val(),
        "theaterNumber" : $('#theaterNumber').val()
    }

    $.ajax({
        url: "/theater/write",
        method: "post",
        data: formData,
        success: (message) => {
            let response = JSON.parse(message);
            if (response.status == "success") {
                Swal.fire({
                    title: "성공",
                    text : "성공적으로 영화 작성이 완료 되었습니다.",
                    icon: "success"
                }).then(()=>{
                    location.href = '/theater/printOne.jsp?id=1'
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