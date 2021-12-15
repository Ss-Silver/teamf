package com.sangeun.teamf.dto;

import lombok.*;

import javax.persistence.*;
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userNum;  //회원 번호

    @Column(nullable = false, length = 30, unique = true)
    private String userId;   //회원 아이디

    @Column(nullable = false)
    private String password;   //회원 비밀번호

    @Column(nullable = false)
    private String userName;  //회원 이름(고객사 명)

    @Column(nullable = false)
    private String phone;   //대표 번호

    @Enumerated(EnumType.STRING)
    private RoleType role;   //회원 구분(관리자, 고객사, 운송사, 기사)

    @Column(nullable = true)
    private int totalMoney;
    // 정산 금액의 영역으로 주문 수락시 고객사는 -금액 , 운송사는 +금액이 된다.
    // 운송사, 고객사 초기값: 0, 기사(지입 가정)는 처음 입력값이며 패널티하여 배상시 -된다.

}
