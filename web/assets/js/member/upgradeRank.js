let upgradeRank = (id) => {
    let data = {
        id: id
    }

    console.log(data)

    $.ajax({
        url: "/admin/upgrade",
        method: "post",
        data: data,
        success: (message) => {
            let response = JSON.parse(message);
            Swal.fire({
                text: response.message,
                icon: response.status
            }).then(() => {
                location.reload();
            })
        }
    })
}

let upgradeMember = (id) => {
    let data = {
        id: id
    }

    console.log(data)

    $.ajax({
        url: "/admin/upgrade",
        method: "post",
        data: data,
        success: (message) => {
            let response = JSON.parse(message);
            Swal.fire({
                text: response.message,
                icon: response.status
            }).then(() => {
                location.href='/admin/memberList.jsp';
            })
        }
    })
}