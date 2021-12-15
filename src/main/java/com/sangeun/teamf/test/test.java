package com.sangeun.teamf.test;

import com.sangeun.teamf.controller.VocController;
import com.sangeun.teamf.dto.Compensation;
import com.sangeun.teamf.dto.User;
import com.sangeun.teamf.dto.Voc;
import com.sangeun.teamf.repository.VocRepository;
import com.sangeun.teamf.service.VocService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class test {
    @Autowired
    VocRepository vocRepository;
    @Autowired
    VocService vocService;

    @GetMapping("/test/voc/{vocNum}")
    public Voc getVoc(@PathVariable int vocNum) {
        return vocRepository.findById(vocNum).get();
    }

    //VOC 오더 상세보기
    @GetMapping("/test/test/{vocNum}")
    public Voc getTest(@PathVariable int vocNum) {
        return vocRepository.findById(vocNum).get();
        //Voc voc = vocService.findById(vocNum);
        //System.out.println(voc);
        //return voc;

    }



}
