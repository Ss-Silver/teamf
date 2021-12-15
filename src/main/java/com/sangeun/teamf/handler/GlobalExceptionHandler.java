package com.sangeun.teamf.handler;

import com.sangeun.teamf.dto.ResponseDto;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;

@ControllerAdvice
@RestController
public class GlobalExceptionHandler {

    @ExceptionHandler(value = Exception.class)
    public ResponseDto<Integer> handleArgumentException(Exception e) {
        System.out.println("에러 발생 리스폰 실행");
        return new ResponseDto<Integer>(HttpStatus.INTERNAL_SERVER_ERROR.value(), 2);
    }

}
