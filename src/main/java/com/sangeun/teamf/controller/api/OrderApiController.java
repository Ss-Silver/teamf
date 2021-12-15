package com.sangeun.teamf.controller.api;

import com.fasterxml.jackson.databind.util.JSONWrappedObject;
import com.sangeun.teamf.dto.OrderBean;
import com.sangeun.teamf.dto.Progress;
import com.sangeun.teamf.dto.ResponseDto;
import com.sangeun.teamf.dto.User;
import com.sangeun.teamf.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
public class OrderApiController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private HttpSession session;

    @PostMapping("/api/orderWrite")
    public ResponseDto<Integer> save(@RequestBody OrderBean orderBean){
        System.out.println(orderBean);
        User principal = (User)session.getAttribute("principal");
        orderBean.setClient(principal);
        orderBean.setProgress(Progress.INFORM);
        orderService.write(orderBean);
        return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
    }

    @PutMapping("/order/take/{orderNum}")
    public ResponseDto<Integer> take(@PathVariable int orderNum, @RequestBody User user) {
        System.out.println("@@@@PUT받는중");
        System.out.println("orderNum : " + orderNum );
        System.out.println("userId : " + user);
        orderService.take(orderNum, user);
        return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
    }

    @PutMapping("/order/update/{orderNum}")
    public ResponseDto<Integer> arrival(@PathVariable int orderNum, @RequestBody String time){
        System.out.println("운송완료 업데이트 실시");
        orderService.update(orderNum, time);
        return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
    }

    @PutMapping("/order/approve/{orderNum}")
    public ResponseDto<Integer> approve(@PathVariable int orderNum, @RequestBody Map<String, Integer> param) {
        Map<String, Integer> result = new HashMap<String, Integer>(param);
        System.out.println("orderNum : " + orderNum);
        System.out.println("result : " + result);
        System.out.println("result.client : " + result.get("client"));
        System.out.println("result.driver : " + result.get("driver"));
        orderService.approve(orderNum, result.get("client"), result.get("driver"));
        return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
    }

}
