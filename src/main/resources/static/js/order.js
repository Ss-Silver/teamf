let index = {
    init: function (){
        $("#btn-save").on("click", () =>{
            this.save();
        });
    },

    save: function() {
        let data = {
            departure : $("#departure").val(),
            destination : $("#destination").val(),
            requestTime : $("#date").val() + "_" + $("#time").val(),
            price : $("#price").val()
        }
        console.log(data)
        $.ajax({
            type: "POST",
            url: "/api/orderWrite",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        }).done(function (resp){
            if(resp.data == 1) {
                alert("오더 등록이 완료되었습니다.");
                location.href ="/";
            } else{
                console.log(resp);
                alert("오더 등록이 실패하였습니다. \n" +
                    "빈칸을 확인해주세요.");
            }
            console.log(data);
            location.href = "/";
        }).fail(function (error){
            alert(JSON.stringify(error))
            alert("등록에 실패하였습니다.");
        });
    }

}
index.init();

function doAction(orderNum) {
    let data = {
        userNum: $("#userNum").val(),
        userId: $("#userId").val(),
        password: $("#password").val(),
        userName: $("#userName").val(),
        phone: $("#phone").val(),
        role: $("#role").val(),
        totalMoney: $("#totalMoney").val()
    }

    $.ajax({
        type: "PUT",
        url: "/order/take/"+orderNum,
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json"

    }).done(function (resp){
        if(resp.data == 1) {
            alert("접수에 완료되었습니다.");
            location.href ="/";
        } else{
            console.log(resp);
            alert("접수에 실패하였습니다. \n" +
                "입력칸을 확인해주세요.");
        }

        console.log(resp);
        location.href = "/order/orderList";
    }).fail(function (error){
        alert(JSON.stringify(error))
        alert("접수에 실패하였습니다.");
    });
}

function doUpdate(orderNum) {
    let time = $("#nowTime").val();
    console.log(time);
    $.ajax({
        type: "PUT",
        url: "/order/update/"+orderNum,
        data: JSON.stringify(time),
        contentType: "application/json; charset=utf-8",
        dataType: "json"

    }).done(function (resp){

        if(resp.data == 1) {
            alert("접수가 완료되었습니다.");
            location.href ="/";
        } else{
            console.log(resp);
            alert("접수에 실패하였습니다. \n" +
                "입력칸을 확인해주세요.");
        }
        console.log(resp);
        location.href = "/order/detail/"+orderNum;
    }).fail(function (error){
        alert(JSON.stringify(error))
        alert("접수에 실패하였습니다.");
    });
}

function doApprove(orderNum) {
    let data = {
            client : $("#cliNum").val(),
            driver : $("#driNum").val()
        };

    console.log(data);
    $.ajax({
        type: "PUT",
        url: "/order/approve/"+orderNum,
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json"

    }).done(function (resp){
        if(resp.data == 1) {
            alert("접수가 완료되었습니다.");
            location.href ="/";
        } else{
            console.log(resp);
            alert("접수에 실패하였습니다. \n" +
                "입력칸을 확인해주세요.");
        }

        console.log(resp);
        location.href = "/order/detail/"+orderNum;
    }).fail(function (error){
        alert(JSON.stringify(error))
        alert("접수에 실패하였습니다.");
    });
}

