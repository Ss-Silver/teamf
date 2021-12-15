package com.sangeun.teamf.controller.api;

import com.sangeun.teamf.dto.*;
import com.sangeun.teamf.service.CompensationService;
import com.sangeun.teamf.service.ComplainService;
import com.sangeun.teamf.service.OrderService;
import com.sangeun.teamf.service.VocService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
public class VocApiController {
    @Autowired
    private VocService vocService;
    @Autowired
    private ComplainService complainService;
    @Autowired
    private CompensationService compensationService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private HttpSession session;
    @Autowired
    HttpServletRequest request;

    @PostMapping("/voc/save/{complainNum}")
    public ResponseDto<Integer> save(@PathVariable int complainNum, @RequestParam Integer realIndemnity, @RequestBody Voc voc) {
        System.out.println("VOC 등록시스템 시작");
        User admin = (User) session.getAttribute("principal");
        Complain complain = complainService.findById(complainNum);
        // 귀책 당사자의 타입(DRIVER, AGENCY)이 실제 운전자 타입 다를 경우 에러메세지를 리턴한다.
        // 두 타입이 같거나 귀책 당사자의 타입이 ADMIN, CLIENT 인 경우는 일반적인 상황으로 진행한다.
        // 만약, 귀책 당사자의 타입이 AGENCY면 배상 절차 등록을 바로 실시한다.
        if(complain.getOrderBean().getDriver().getRole() == RoleType.AGENCY && voc.getResponsibility() == RoleType.DRIVER) {
            System.out.println("배송담당자는 DRIVER가 아닙니다. -> AGENCY체크 필요");
            return new ResponseDto<Integer>(HttpStatus.BAD_REQUEST.value(), 2);
        } else if(complain.getOrderBean().getDriver().getRole() == RoleType.DRIVER && voc.getResponsibility() == RoleType.AGENCY) {
            System.out.println("배송담당자는 AGENCY가 아닙니다. -> DRIVER체크 필요");
            return new ResponseDto<Integer>(HttpStatus.BAD_REQUEST.value(), 2);
        } else if (complain.getOrderBean().getDriver().getRole() == RoleType.AGENCY && voc.getResponsibility() == RoleType.AGENCY) {
            System.out.println("귀책 책임자가 AGENCY이므로 바로 배상시스템 등록 시작");

            voc.setAdmin(admin);
            voc.setComplain(complain);
            voc.setVocProgress(VocProgress.END);

            OrderBean summaryOb = voc.getComplain().getOrderBean();

            Compensation compensation = new Compensation();
            compensation.setVoc(voc);
            compensation.setUser(admin);
            compensation.setRealIndemnity(realIndemnity);
            System.out.println("귀책 책임자가 AGENCY이므로 바로 배상시스템 등록 완료");

            //배상 시스템 등록 완료
            compensationService.write(compensation);

            // 배상 적용하기 -> 고객사, 운송사 totalMoney반영
            System.out.println("귀책 책임자가 AGENCY이므로 바로 배상적용");
            compensationService.apply(compensation);

            System.out.println("귀책 책임자가 AGENCY이므로 바로 배상시스템 적용으로 / 오더Bean의 상태는 승인으로 변경한다.");

            //오더를 승인으로 변경하며, 기존 운임에 대한 것은 정산한다.
            orderService.approve(
                    summaryOb.getOrderNum(), summaryOb.getClient().getUserNum(),
                    summaryOb.getDriver().getUserNum());

            session = request.getSession();

            return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
        } else{  // 귀책 책임자가 기사인경우 시행됨.
            System.out.println("귀책 책임자가 기사 배상시스템 등록 시작");

            voc.setAdmin(admin);
            voc.setComplain(complain);
            voc.setVocProgress(VocProgress.ENROLL);

            OrderBean summaryOb = voc.getComplain().getOrderBean();

            Compensation compensation = new Compensation();
            compensation.setVoc(voc);
            compensation.setUser(admin);
            compensation.setRealIndemnity(realIndemnity);
            System.out.println("귀책 책임자가 DRIVER이므로 배상시스템 등록 완료 / 반영은 안함.");

            //배상 시스템 등록 완료
            compensationService.write(compensation);
            // 운송사와는 다르게 배상 글만 작성함

            vocService.write(voc);



            return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
        }
    }

    //기사확인 버튼 클릭시 -> voc의 진행상태는 driChk로 변환, chkDriver 는 true로 변환
    @PutMapping("/voc/chkDriver/{vocNum}")
    public ResponseDto<Integer> chkDriver(@PathVariable int vocNum) {
        System.out.println("기사 확인 API Controller 시작");
        System.out.println("vocNum : " + vocNum);
        vocService.chkDriver(vocNum);
        return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
    }

    @PutMapping("/voc/confirm/{vocNum}/{compensationNum}")
    public ResponseDto<Integer> confirm(@PathVariable int vocNum, @PathVariable int compensationNum){
        System.out.println("기사 승인 API Controller 시작");
        Voc voc = vocService.findById(vocNum);
        Compensation compensation = compensationService.findByNum(compensationNum);

        voc.setVocProgress(VocProgress.END);

        System.out.println("배상적용");
        compensationService.apply(compensation);

        OrderBean summaryOb = voc.getComplain().getOrderBean();

        orderService.approve(
                summaryOb.getOrderNum(), summaryOb.getClient().getUserNum(),
                summaryOb.getDriver().getUserNum());

        session = request.getSession();

        return new ResponseDto<Integer>(HttpStatus.OK.value(), 1);
    }



}
