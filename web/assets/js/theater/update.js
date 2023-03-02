let updateTheater = () => {
    let data = {
        id: $('#theaterId').val(),
        theaterName: $('#theaterName').val(),
        theaterPlace: $('#theaterPlace').val(),
        theaterNumber: $('#theaterNumber').val()
    }

    $.ajax({
        url: "/theater/update",
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