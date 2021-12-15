
function doSave(compensationNum) {
    let money = $("#money").val();
    let vocNum = $("#vocNum").val();
    let data = {
        title : $("#title").val(),
        content : $("#content").val(),
    }
    console.log(data);
    $.ajax({
        type: "POST",
        url: "/appeal/save/"+compensationNum+"?money="+money,
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json"
    }).done(function (resp){
        if(resp.data == 1) {
            alert("이의제기 접수가 완료되었습니다.");
            location.href ="/voc/detail/"+ vocNum;
        } else{
            console.log(resp);
            alert("이의제기 접수에 실패하였습니다. \n" +
                "입력칸을 확인해주세요.");
        }
        console.log(resp);
        location.href = "/order/detail/"+orderNum;
    }).fail(function (error){
        alert(JSON.stringify(error))
        alert("컴플레인 등록이 실패되었습니다.");
    });
}


