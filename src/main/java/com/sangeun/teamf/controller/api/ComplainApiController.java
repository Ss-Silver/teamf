package com.sangeun.teamf.controller.api;

import com.sangeun.teamf.dto.Complain;
import com.sangeun.teamf.dto.OrderBean;
import com.sangeun.teamf.dto.Progress;
import com.sangeun.teamf.dto.ResponseDto;
import com.sangeun.teamf.service.ComplainService;
import com.sangeun.teamf.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ComplainApiController {
    @Autowired
    private ComplainService complainService;
    @Autowired
    private OrderService orderService;

    @PostMapping("/complain/save/{orderNum}")
    public ResponseDto<Integer> save(@PathVariable int orderNum, @RequestBody Complain complain) {
        System.out.println("컴플레인 등록시스템 시작");
        System.out.println("넘어온 complain : "+complain);
        OrderBean orderBean = orderService.findById(orderNum);


        orderBean.setProgress(Progress.CLAIM);
        complain.setOrderBean(orderBean);
        complainService.write(complain);
        return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
    }
}
