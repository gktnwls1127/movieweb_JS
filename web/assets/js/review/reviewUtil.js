let writeReview = () => {
    let formData = {
        filmId: new URLSearchParams(window.location.search).get("id"),
        score: $('input[name="score"]:checked').val(),
        review: $('#review').val()
    }
    if(formData.score == undefined){
        formData.score = 0;
    }
    console.log($('input[name="score"]:checked').val())
    console.log(formData);

    $.ajax({
        url: "/review/write",
        method: "post",
        data: formData,
        success: (message) => {
            let response = JSON.parse(message);
            if (response.status == "fail") {
                Swal.fire({
                    title: "!!! ERROR !!!",
                    text: "에러가 발생하였습니다.",
                    icon: "error"
                }).then(() => {
                    location.reload()
                })
            } else {
                Swal.fire({
                    title: "작성 완료",
                    text: "평점 작성이 완료되었습니다.",
                    icon: "success"
                }).then(() => {
                    location.reload()
                })
            }
        }
    })
}

function deleteReview(id) {
    let sendData = {
        "id": id,
    }
    Swal.fire({
        title: '평점 삭제',
        text: "정말로 삭제 하시겠습니까?",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes'
    }) .then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: "/review/delete",
                method: "get",
                data: sendData,
                success: (message) => {
                    let response = JSON.parse(message);
                    if (response.status == 'fail') {
                        Swal.fire({text: "오류가 발생하였습니다.", title: "!!! ERROR !!!"}).then(() => {
                            location.reload();
                        });
                    } else {
                        Swal.fire(
                            '삭제완료!',
                            '성공적으로 평점이 삭제 되었습니다.',
                            'success',
                        ).then(() => {
                            location.reload();
                        })
                    }
                }
            })

        }
    })


}

function updateUi(td, reply) {
    let tr = $(td).parent();
    $(tr).html("");

    let form =
        $(document.createElement("input"))
            .attr("type", "text").addClass("form-control")
            .val(reply.content).attr("id", "input-update" + reply.id);
    let btnUpdate =
        $(document.createElement("div")).addClass("btn btn-success w-25").click(updateReview(review));
    let newTd = $(document.createElement("td")).attr("colspan", "2").append(form).append(btnUpdate);

    $(tr).append(newTd);
}

function updateReview(review) {
    let score = $('input[name="updateScore"]:checked').val();
    let content = $('#review' + review.id).val();
    let formData = {
        "score": score,
        "review": content,
        "id": review.id
    }
    $.ajax({
        url: "/review/update",
        method: "post",
        data: formData,
        success: (message) => {
            let response = JSON.parse(message);
            if (response.status == 'fail') {
                Swal.fire({text: "오류가 발생하였습니다.", title: "!!! ERROR !!!"});
            }
            location.reload();
        }
    })
}