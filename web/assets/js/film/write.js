let writeFilm = () => {
    let form = $('#formData')[0];
    let formData = new FormData(form);

    $.ajax({
        url: "/film/write",
        method: "post",
        enctype: 'multipart/form-data',
        processData: false, //false로 선언 시 formData를 string으로 변환하지 않음
        contentType: false, //false 로 선언 시 content-type 헤더가 multipart/form-data로 전송되게 함
        data: formData,
        success: (message) => {
            let response = JSON.parse(message);
            if (response.status == "success") {
                Swal.fire({
                    title: "성공",
                    text : "성공적으로 영화 작성이 완료 되었습니다.",
                    icon: "success"
                }).then(()=>{
                    location.href = '/film/printList.jsp'
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