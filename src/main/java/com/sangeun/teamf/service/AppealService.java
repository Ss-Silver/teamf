package com.sangeun.teamf.service;

import com.sangeun.teamf.dto.Appeal;
import com.sangeun.teamf.dto.Complain;
import com.sangeun.teamf.repository.AppealRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class AppealService {
    @Autowired
    AppealRepository appealRepository;

    @Transactional
    public void write(Appeal appeal){
        appealRepository.save(appeal);
    }


}
