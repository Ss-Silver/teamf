package com.sangeun.teamf.controller;

import com.sangeun.teamf.dto.OrderBean;
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
public class OrderController {

    @Autowired
    private OrderService orderService;

    @GetMapping({"","/"})
    public String index(){
        return "index";
    }

    //전체 오더리스트
    @GetMapping("/order/orderList")
    public String orderList(Model model, @PageableDefault(size = 100, sort="orderNum", direction = Sort.Direction.DESC)Pageable pageable) {
        Page<OrderBean> orderDtoPage = orderService.orderListAll(pageable);
        List<OrderBean> orderList = orderDtoPage.getContent();

        model.addAttribute("orderList", orderList);
        return "order/orderList";
    }

    //내 오더리스트 (고객사 전용)
    @GetMapping("/order/orderList/client/{userNum}")
    public String findById(@PathVariable int userNum, Model model){
        List<OrderBean> cOrderList = orderService.cOrderList(userNum);
        model.addAttribute("orderList", cOrderList);
        return "order/myOrderList";
    }

    @GetMapping("/order/orderList/driver/{userNum}")
    //내 오더리스트(기사/운송사 전용)
    public String dfindById(@PathVariable int userNum, Model model){
        List<OrderBean> dOrderList = orderService.dOrderList(userNum);
        model.addAttribute("orderList", dOrderList);
        return "order/myOrderList";
    }

    @GetMapping("/order/orderWriteForm")
    public String orderWriteForm() {
        return "order/orderWriteForm";
    }

    //오더 상세보기
    @GetMapping("/order/detail/{orderNum}")
    public String orderDetail(@PathVariable int orderNum, Model model) {
        OrderBean orderBean = orderService.findById(orderNum);
        System.out.println(orderBean);
        model.addAttribute("orderBean", orderBean);
        return "/order/orderDetail";
    }
}
