let promote = () => {
    let data = {
        level: $('#level').val()
    }

    console.log(data)

    $.ajax({
        url: "/member/promote",
        method: "post",
        data: data,
        success: (message) => {
            let response = JSON.parse(message);
            Swal.fire({
                text: response.message,
                icon: response.status
            }).then(() => {
                location.href = response.nextPath;
            })
        }
    })
}