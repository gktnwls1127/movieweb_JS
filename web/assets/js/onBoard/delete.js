function deleteOnBoard(id){
    let sendData = {
        "id" : id,
    }
    $.ajax({
        url : "/onBoard/delete",
        method : "get",
        data : sendData,
        success : (message) => {
            let response = JSON.parse(message);
            if (response.status == 'success'){
                Swal.fire({text : "성공적으로 삭제 되었습니다.",title: "삭제 완료", icon : "success"}).then(()=> {
                    location.href = '/onBoard/printList.jsp';
                })
            } else {
                Swal.fire({text : "오류가 발생하였습니다.",title: "!!! ERROR !!!" }).then(()=> {
                    location.reload();
                })
            }

        }
    })
}