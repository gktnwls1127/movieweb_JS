let updateOnBoard = () => {
    let data = {
        id: $('#onBoardId').val(),
        filmId: $('#filmId').val(),
        theaterId: $('#theaterId').val(),
        runningTime: $('#runningTime').val()
    }

    console.log(data)

    $.ajax({
        url: "/onBoard/update",
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