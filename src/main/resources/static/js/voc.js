function doSave(complainNum) {
    let realIndemnity = $("#realIndemnity").val();
    let data = {
        responsibility : $("input[name='role']:checked").val(),
        causes : $("#causes").val(),
        penalty : $("#penalty").val()
    }
    console.log(data);
    $.ajax({
        type: "POST",
        url: "/voc/save/"+complainNum+"?realIndemnity="+realIndemnity,
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        dataType: "json"

    }).done(function (resp){
        if(resp.data == 1) {
            alert("VOC 등록이 완료되었습니다.");
            location.href ="/";
        } else{
            console.log(resp);
            alert("VOC 등록이 실패하였습니다. \n" +
                "입력칸을 확인해주세요.");
        }

        console.log(resp);
        location.href = "/order/detail/"+complainNum;
    }).fail(function (error){
        alert(JSON.stringify(error))
        alert("VOC 등록이 실패하였습니다.");
    });
}

function chkDriver(vocNum) {
    $.ajax({
        type: "PUT",
        url: "/voc/chkDriver/"+vocNum,
        contentType: "application/json; charset=utf-8",
        dataType: "json"

    }).done(function (resp){
        if(resp.data == 1) {
            alert("기사 확인이 완료되었습니다.");
            location.href ="/";
        } else{
            console.log(resp);
            alert("기사 확인이 실패하였습니다.");
        }
        console.log(resp);
        location.href = "/voc/detail/"+vocNum;
    }).fail(function (error){
        alert(JSON.stringify(error))
        alert("기사 확인이 실패하였습니다.");
    });
}

function confirm(vocNum, compensationNum) {
    console.log(vocNum, compensationNum);
    $.ajax({
        type: "PUT",
        url: "/voc/confirm/"+vocNum+"/"+compensationNum,
        contentType: "application/json; charset=utf-8",
        dataType: "json"

    }).done(function (resp){
        if(resp.data == 1) {
            alert("승인이 완료되었습니다.");
            location.href ="/";
        } else{
            console.log(resp);
            alert("승인이 실패하였습니다.");
        }
        console.log(resp);
        location.href = "/voc/detail/"+vocNum;
    }).fail(function (error){
        alert(JSON.stringify(error))
        alert("승인이 실패하였습니다.");
    });
}




