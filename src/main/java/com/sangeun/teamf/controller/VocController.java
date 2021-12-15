package com.sangeun.teamf.controller;

import com.sangeun.teamf.dto.Complain;
import com.sangeun.teamf.dto.OrderBean;
import com.sangeun.teamf.dto.Voc;
import com.sangeun.teamf.repository.VocRepository;
import com.sangeun.teamf.service.ComplainService;
import com.sangeun.teamf.service.VocService;
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
import java.util.Optional;

@Controller
public class VocController {
    @Autowired
    private VocService vocService;
    @Autowired
    private ComplainService complainService;
    @Autowired
    private VocRepository vocRepository;

    @GetMapping("/voc/form/{complainNum}")
    public String complainForm(@PathVariable int complainNum, Model model) {
        Complain complain = complainService.findById(complainNum);
        model.addAttribute("complain", complain);
        return "/voc/vocForm";
    }

    @GetMapping("/voc/list")
    public String vocList(Model model, @PageableDefault(size=100, sort = "vocNum", direction = Sort.Direction.DESC)Pageable pageable){
        Page<Voc> page = vocService.vocPage(pageable);
        List<Voc> vocList = page.getContent();
        model.addAttribute("vocList", vocList);
        return "voc/vocList";
    }

    //고객용 리스트
    @GetMapping("/voc/cliList/")
    public String cliVocList(Model model, @PageableDefault(size=100, sort = "vocNum", direction = Sort.Direction.DESC)Pageable pageable){
        Page<Voc> page = vocService.vocPage(pageable);
        List<Voc> vocList = page.getContent();
        model.addAttribute("vocList", vocList);
        return "/voc/cl_vocList";
    }

    // 기사 / 운송사 전용 리스트
   @GetMapping("/voc/driList/")
    public String driVocList(Model model, @PageableDefault(size=100, sort = "vocNum", direction = Sort.Direction.DESC)Pageable pageable){
        Page<Voc> page = vocService.vocPage(pageable);
        List<Voc> vocList = page.getContent();
        model.addAttribute("vocList", vocList);
        return "/voc/dr_vocList";
    }

    //VOC 오더 상세보기
    @GetMapping("/voc/detail/{vocNum}")
    public String vocDetail(@PathVariable int vocNum, Model model) {
        System.out.println("vocNum : " + vocNum);
        Voc voc = vocService.findById(vocNum);
        System.out.println(voc);
        model.addAttribute("voc", voc);
        return "/voc/dr_vocDetail";
    }

}