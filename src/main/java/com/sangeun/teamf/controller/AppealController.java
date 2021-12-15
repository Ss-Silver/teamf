package com.sangeun.teamf.controller;

import com.sangeun.teamf.dto.Voc;
import com.sangeun.teamf.service.VocService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@Controller
public class AppealController {
    @Autowired
    VocService vocService;

    @GetMapping("/appeal/form/{vocNum}")
    public String appealForm(@PathVariable int vocNum, Model model) {
        Voc voc = vocService.findById(vocNum);
        model.addAttribute("voc", voc);
        return "/appeal/appealForm";
    }
}
