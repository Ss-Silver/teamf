package com.sangeun.teamf.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class UserController {

    @GetMapping("auth/joinForm")
    public String joinForm(){
        return "user/joinForm";
    }

    @GetMapping("auth/loginForm")
    public String loginForm(){
        return "user/loginForm";
    }

    @GetMapping("user/ad_joinForm")
    public String ad_joinForm() {
        return "user/ad_joinForm";
    }

    @GetMapping("/auth/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "index";
    }

}
