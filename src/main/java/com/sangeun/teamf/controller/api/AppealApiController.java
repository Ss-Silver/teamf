package com.sangeun.teamf.controller.api;

import com.sangeun.teamf.dto.*;
import com.sangeun.teamf.service.AppealService;
import com.sangeun.teamf.service.CompensationService;
import com.sangeun.teamf.service.VocService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
public class AppealApiController {

    @Autowired
    private HttpSession session;
    @Autowired
    private HttpServletRequest request;
    @Autowired
    private CompensationService compensationService;
    @Autowired
    private VocService vocService;
    @Autowired
    private AppealService appealService;



    @PostMapping("/appeal/save/{compensationNum}")
    public ResponseDto<Integer> save(@PathVariable int compensationNum, @RequestParam Integer money, @RequestBody Appeal appeal) {
        System.out.println("이의제기 등록시스템 시작");

        User user = (User) session.getAttribute("principal");
        System.out.println("배상 객체 영속화");
        Compensation compensation = compensationService.findByNum(compensationNum);
        int vocNum = compensation.getVoc().getVocNum();
        System.out.println("VOC 객체 영속화");
        Voc voc = vocService.findById(vocNum);
        System.out.println("VOC num = "+ voc.getVocNum());
        System.out.println("VOC progress = "+ voc.getVocProgress());

        //배상 시스템 내 돈 업데이트
        int pastMoney = compensation.getRealIndemnity();
        compensation.setRealIndemnity(money);
        compensation.setPastIndemnity(pastMoney);

        //이의제기 시스템 내 돈 업데이트
        appeal.setPast(pastMoney);
        appeal.setRenew(money);

        appeal.setCompensation(compensation);

        if (user.getRole() == RoleType.CLIENT) {
            voc.setVocProgress(VocProgress.CLIAPPEAL);
            System.out.println("VOC progress = "+ voc.getVocProgress());
            appealService.write(appeal);

            return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
        } else if (user.getRole() == RoleType.DRIVER) {
            voc.setVocProgress(VocProgress.DRIAPPEAL);
            System.out.println("VOC progress = "+ voc.getVocProgress());
            appealService.write(appeal);

            return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
        } else {
            System.out.println("잘못된 사용자입니다.");
            return new ResponseDto<Integer>(HttpStatus.BAD_REQUEST.value(), 2);
        }
    }

}
