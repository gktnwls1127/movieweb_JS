let writeReview = () => {
    let formData = {
        filmId : new URLSearchParams(window.location.search).get("filmId"),
        score : $('#score').val(),
        review : $('#review').val()
    }
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
                }).then(()=>{location.reload()})
            }
            location.reload();
        }
    })
}

function printReply(boardId) {
    let sendData = {
        "boardId": boardId
    }
    $.ajax({
        url: "/review/selectAll",
        method: "get",
        data: sendData,
        success: (message) => {
            let response = JSON.parse(message);
            let replyArray = JSON.parse(response.list);
            printList(replyArray);
        }
    })
}

function printList(replyArray) {

    if (replyArray.length == 0) {
        $('#tbody-reply').append(
            $(document.createElement("tr")).append(
                $(document.createElement("td")).attr("colspan", "2").text("아직 등록된 댓글이 존재하지 않습니다.")
            ));
    } else {
        replyArray.forEach(reply => {
                let tr = $(document.createElement("tr"));
                let td = $(document.createElement("td")).attr("colspan", "2")
                let str = reply.writer + " : " + reply.content + " at " + reply.date;
                $(td).text(str);
                if (reply.isOwned == true){
                    let btnUpdate = $(document.createElement("div")).addClass("btn btn-success").text("수정");
                    btnUpdate.click(() => {
                        updateUi(td, reply);
                    })
                    let btnDelete = $(document.createElement("div")).addClass("btn btn-danger").text("삭제");
                    btnDelete.click(() => {
                        deleteReply(reply.id);
                    })
                    $(td).append(btnUpdate);
                    $(td).append(btnDelete);
                }

                $(tr).append(td);
                $('#tbody-reply').append(tr)
            }
        );
    }

}

function deleteReview(id){
    let sendData = {
        "id" : id,
    }
    $.ajax({
        url : "/review/delete",
        method : "get",
        data : sendData,
        success : (message) => {
            let response = JSON.parse(message);
            if (response.status == 'fail'){
                Swal.fire({text : "오류가 발생하였습니다.",title: "!!! ERROR !!!" });
            }
            else {
                Swal.fire({
                    title: '평점 삭제',
                    text: "정말로 삭제 하시겠습니까?",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes'
                }).then((result) => {
                    if (result.isConfirmed) {
                        Swal.fire(
                            '삭제완료!',
                            '성공적으로 평점이 삭제 되었습니다.',
                            'success',
                        ).then(()=> {
                            location.reload();
                        })
                    } else {
                        location.reload();
                    }
                })
            }
        }
    })
}

function updateUi(td, reply){
    let tr = $(td).parent();
    $(tr).html("");

    let form =
        $(document.createElement("input"))
            .attr("type", "text").addClass("form-control")
            .val(reply.content).attr("id", "input-update" + reply.id);
    let btnUpdate =
        $(document.createElement("div")).addClass("btn btn-success w-25").click(updateReply(reply));
    let newTd = $(document.createElement("td")).attr("colspan", "2").append(form).append(btnUpdate);

    $(tr).append(newTd);
}

function updateReview(reply){
    let score = ""
    let content = $('#input-update' + reply.id).val();
    let formData = {
        "score" : score,
        "content" : content,
        "id" : reply.id
    }
    $.ajax({
        url : "/review/update",
        method : "post",
        data : formData,
        success : (message) => {
            let response = JSON.parse(message);
            if (response.status == 'fail'){
                Swal.fire({text : "오류가 발생하였습니다.",title: "!!! ERROR !!!" });
            }
            location.reload();
        }
    })
}