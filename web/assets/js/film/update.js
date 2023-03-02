let updateFilm = () => {
    let formData = new FormData();
    formData.set("id", $('#id').val())
    formData.set("title", $('#title').val())
    formData.set("rating", $('#rating').val())
    formData.set("images", $('#images')[0].files[0])
    formData.set("summary", $('#summary').val())

    $.ajax({
        url: "/film/update",
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
                    text : response.message,
                    icon: response.status
                }).then(()=>{
                    location.href = response.nextPath
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