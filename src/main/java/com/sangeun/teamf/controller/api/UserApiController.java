package com.sangeun.teamf.controller.api;

import com.sangeun.teamf.dto.ResponseDto;
import com.sangeun.teamf.dto.User;
import com.sangeun.teamf.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;

@RestController
public class UserApiController {

    @Autowired
    private UserService userService;

    @PostMapping("/auth/joinProc")
    public ResponseDto<?> save(@RequestBody User user) {
        System.out.println("UserApiController : save 호출이 완료됨");
        System.out.println("User : //" + user);
        userService.write(user);
        return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
    }

    @PostMapping("/user/idCheck")
    @ResponseBody
    public String idCheck(@RequestParam("userId") String userId) {
        System.out.println("userIdCheck 진입");
        System.out.println("userid :" + userId);
        String cnt = userService.idCheck(userId);
        System.out.println("cnt : " + cnt);
        return cnt;

    }

    @PostMapping("/auth/login")
    public ResponseDto<Integer> login(@RequestBody User user, HttpSession session) {
        System.out.println("UserApiController : login 호출이 완료됨");
        User principal = userService.login(user);
        if(principal != null) {
            session.setAttribute("principal", principal);
            System.out.println("로그인 성공");
            return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
        }else {
            System.out.println("로그인 실패");
            ResponseDto<Integer> error = new ResponseDto<Integer>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 2);
            System.out.println(error);
            return error;
        }
    }



}
