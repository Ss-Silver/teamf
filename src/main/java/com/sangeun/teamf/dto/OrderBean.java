package com.sangeun.teamf.dto;

import lombok.*;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class OrderBean {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int orderNum;  //주문 번호

    @Column(nullable = false)
    private String departure;  //출발지

    @Column(nullable = false)
    private String destination;  //도착지

    @Column(nullable = true)
    private String arriveTime;  // 배송 완료일(기사님이 운행종료 현재시간)

    @Column(nullable = false)
    private String requestTime;  // 요청 도착 시간

    @Column(nullable = false)
    private int price;  // 운송 비용

    @Enumerated(EnumType.STRING)
    private Progress progress;  //진행 상태

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="clientNum")
    private User client;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="driverNum")
    private User driver;

}
