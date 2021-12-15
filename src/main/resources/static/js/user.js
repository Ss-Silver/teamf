let index = {
    init: function (){
        $("#btn-save").on("click", () =>{
            this.save();
        });
        $("#btn-login").on("click", () =>{
            this.login();
        });

    },

    save: function() {
        let data = {
            role : $("input[name='role']:checked").val(),
            userId : $("#userId").val(),
            password : $("#pwd1").val(),
            userName : $("#userName").val(),
            phone : $("#phone1").val() +"-"+$("#phone2").val() +"-"+$("#phone3").val(),
            totalMoney : $("#totalMoney").val()
        }

        console.log(data);
        $.ajax({
            type: "POST",
            url: "/auth/joinProc",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        }).done(function (data){
            alert("등록이 완료되었습니다.");
            location.href = "/";
        }).fail(function (error){
            alert(JSON.stringify(error))
            alert("등록에 실패하였습니다.");
        });
    },
    login: function() {
        let data = {
            userId : $("#userId").val(),
            password : $("#password").val(),
        }
        $.ajax({
            type: "POST",
            url: "/auth/login",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        }).done(function (resp){
            if(resp.data == 1) {
                alert("로그인이 완료되었습니다.");
                location.href ="/";
            } else{
                console.log(resp);
                alert("로그인이 실패하였습니다. \n" +
                    "아이디 혹은 비밀번호를 확인해주세요.");
            }
        }).fail(function (error){
            alert(JSON.stringify(error))
            alert("로그인에 실패하였습니다.");
        });
    },
}
index.init();


function checkId() {
    var userId = $("#userId").val();

    $.ajax({
        type: "POST",
        url: "/user/idCheck",
        data: {userId:userId},
        dataType: "text"
    }).done(function (cnt){
        console.log("처리 성공 시 변경되는 내용");
        if(cnt != "1") {
            $('.id_ok').css("display","inline-block");
            $('.id_already').css("display", "none");
        } else { // cnt가 1일 경우 -> 이미 존재하는 아이디
            $('.id_already').css("display","inline-block");
            $('.id_ok').css("display", "none");
        }
    }).fail(function (error){
        alert("에러 입니다.");
    });
}

$(function(){
    $("#pwd2").keyup(function(){
        var pwd1=$("#pwd1").val();
        var pwd2=$("#pwd2").val();
        if(pwd1 != "" || pwd2 != "") {
            if(pwd1 == pwd2) {
                $(".pw_ok").css("display","inline-block");
                $(".pw_no").css("display", "none");}
            else{ $(".pw_ok").css("display", "none");
                $(".pw_no").css("display","inline-block");
            }
        }
    });
});

$(function(){
    $("#phone3").keyup(function(){
        let userId = $("#userId").val();
        let userName = $("#userName").val();
        let phone1 = $("#phone1").val();
        let phone2 = $("#phone2").val();
        let phone3 = $("#phone3").val();
        let pwd1=$("#pwd1").val();
        let pwd2=$("#pwd2").val();

        if(userId != "" && userName != "" && phone1 != "" &&
        phone2 != "" && phone3 != "" && pwd1 != "" && pwd2 != "")
        {
            if(pwd1 == pwd2) {
                $("#btn-save").removeAttr("disabled")
            }
        }

    });
});

