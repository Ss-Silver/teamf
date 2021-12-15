package com.sangeun.teamf.service;

import com.sangeun.teamf.dto.OrderBean;
import com.sangeun.teamf.dto.Progress;
import com.sangeun.teamf.dto.RoleType;
import com.sangeun.teamf.dto.User;
import com.sangeun.teamf.repository.OrderRepository;
import com.sangeun.teamf.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@Service
public class OrderService {
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private UserRepository userRepository;
    @Transactional
    public void write(OrderBean orderBean) {
        orderRepository.save(orderBean);
    }

    @Transactional(readOnly = true)
    public Page<OrderBean> orderListAll(Pageable pageable){
        return orderRepository.findAll(pageable);
    }
    //고객사 전용 검색기능
    @Transactional(readOnly = true)
    public List<OrderBean> cOrderList(int userNum){
        return orderRepository.cOrderList(userNum);
    }
    //기사/운송사 전용 검색기능
    @Transactional(readOnly = true)
    public List<OrderBean> dOrderList(int userNum) { return orderRepository.dOrderList(userNum);};
    //컴플레인 리스트 전용 검색
    @Transactional(readOnly = true)
    public List<OrderBean> complainList() {return orderRepository.complainList();}

    @Transactional
    public void take(int orderNum, User user){
        System.out.println("운송 접수 시작");
        OrderBean orderBean = orderRepository.findById(orderNum)
                .orElseThrow(()-> {
                    return new IllegalArgumentException("글 찾기 실패 : 기존 글을 찾을 수 없습니다.");
                });
        orderBean.setDriver(user);
        orderBean.setProgress(Progress.TAKE);

    }
    @Transactional(readOnly = true)
    public OrderBean findById(int orderNum){
        return orderRepository.findById(orderNum)
                .orElseThrow(()-> {
                    return new IllegalArgumentException("글 찾기 실패 : 기존 글을 찾을 수 없습니다.");
                });
    }

    @Transactional
    public OrderBean update(int orderNum, String time){
        OrderBean orderBean = orderRepository.findById(orderNum)
                .orElseThrow(() ->{
                    return new IllegalArgumentException("글 찾기 실패 : 기존 글을 찾을 수 없습니다.");
                });
        orderBean.setArriveTime(time);
        orderBean.setProgress(Progress.DELIVERED);
        return orderBean;
    }
    @Transactional
    public OrderBean approve(int orderNum, int clientNum, int driverNum){
        OrderBean orderBean = orderRepository.findById(orderNum)
                .orElseThrow(() ->{
                    return new IllegalArgumentException("글 찾기 실패 : 기존 글을 찾을 수 없습니다.");
                });
        User client = userRepository.findByUserNum(clientNum);
        User driver = userRepository.findByUserNum(driverNum);
        int price = orderBean.getPrice();
        client.setTotalMoney(client.getTotalMoney() - price);
        if(driver.getRole() == RoleType.AGENCY) {
            driver.setTotalMoney(driver.getTotalMoney() + price);
        }
        System.out.println("가격" + orderBean.getPrice());
        System.out.println("client 토탈머니" + client.getTotalMoney());
        System.out.println("driver 토탈머니" + driver.getTotalMoney());
        orderBean.setProgress(Progress.APPROVED);
        System.out.println("progress" + orderBean.getProgress());
        return orderBean;
    }

}
