package com.sangeun.teamf.service;

import com.sangeun.teamf.dto.Complain;
import com.sangeun.teamf.dto.OrderBean;
import com.sangeun.teamf.repository.ComplainRepository;
import com.sangeun.teamf.repository.OrderRepository;
import com.sangeun.teamf.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;

@Service
public class ComplainService {
    @Autowired
    ComplainRepository complainRepository;
    @Autowired
    OrderRepository orderRepository;
    @Autowired
    UserRepository userRepository;

    @Transactional
    public void write(Complain complain){
        complainRepository.save(complain);
    }

    @Transactional(readOnly = true)
    public Page<Complain> complainPage(Pageable pageable){
        return complainRepository.findAll(pageable);
    }

    @Transactional(readOnly = true)
    public Complain findById(int complainNum){
        return complainRepository.findById(complainNum)
                .orElseThrow(()-> {
                    return new IllegalArgumentException("글 찾기 실패 : 기존 글을 찾을 수 없습니다.");
                });
    }

}
