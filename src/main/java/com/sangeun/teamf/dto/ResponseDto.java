package com.sangeun.teamf.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class ResponseDto<T> {

    private int status;
    private T data;

    public ResponseDto(int status) {
        super();
        this.status = status;
    }

    public ResponseDto(int status, T data) {
        super();
        this.status = status;
        this.data = data;
    }
}
