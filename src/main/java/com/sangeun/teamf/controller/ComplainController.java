package com.sangeun.teamf.controller;

import com.sangeun.teamf.dto.Complain;
import com.sangeun.teamf.dto.OrderBean;
import com.sangeun.teamf.service.ComplainService;
import com.sangeun.teamf.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class ComplainController {
    @Autowired
    private ComplainService complainService;
    @Autowired
    private OrderService orderService;

    @GetMapping("/complain/form/{orderNum}")
    public String complainForm(@PathVariable int orderNum, Model model) {
        OrderBean orderBean = orderService.findById(orderNum);
        model.addAttribute("orderBean", orderBean);
        return "/complain/complainForm";
    }

    //컴플레인 오더리스트 (관리자 전용)
    @GetMapping("/complain/List")
    public String findComplainList(Model model, @PageableDefault(size=100, sort="complainNum", direction = Sort.Direction.DESC)Pageable pageable){
        Page<Complain> page = complainService.complainPage(pageable);
        List<Complain> complainList = page.getContent();
        model.addAttribute("complainList", complainList);
        return "complain/complainList";
    }

    //컴플레인 오더 상세보기
    @GetMapping("/complain/detail/{complainNum}")
    public String complainDetail(@PathVariable int complainNum, Model model) {
        Complain complain = complainService.findById(complainNum);
        System.out.println(complain);
        model.addAttribute("complain", complain);
        return "/complain/complainDetail";
    }

}
