package com.sangeun.teamf.service;

import com.sangeun.teamf.dto.*;
import com.sangeun.teamf.repository.CompensationRepository;
import com.sangeun.teamf.repository.OrderRepository;
import com.sangeun.teamf.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CompensationService {
    @Autowired
    CompensationRepository compensationRepository;
    @Autowired
    OrderRepository orderRepository;
    @Autowired
    UserRepository userRepository;

    public Compensation findByNum(int compensationNum){
        return compensationRepository.findById(compensationNum)
                .orElseThrow(()-> {
                    return new IllegalArgumentException("글 찾기 실패 : 기존 글을 찾을 수 없습니다.");
                });
    }

    @Transactional
    public void write(Compensation compensation){
        compensationRepository.save(compensation);
    }

    @Transactional
    public void apply(Compensation compensation){
        OrderBean obSummary = compensation.getVoc().getComplain().getOrderBean();

        OrderBean orderBean = orderRepository.findById(obSummary.getOrderNum())
                .orElseThrow(() ->{
                    return new IllegalArgumentException("글 찾기 실패 : 기존 글을 찾을 수 없습니다.");
                });

        User client = userRepository.findByUserNum(orderBean.getClient().getUserNum());
        User driver = userRepository.findByUserNum(orderBean.getDriver().getUserNum());
        int realIndemnity = compensation.getRealIndemnity();

        client.setTotalMoney(client.getTotalMoney() + realIndemnity);
        driver.setTotalMoney(driver.getTotalMoney() - realIndemnity);

        orderBean.setProgress(Progress.APPROVED);
        System.out.println("배상 적용 트랜젝션 종료");
    }
}
