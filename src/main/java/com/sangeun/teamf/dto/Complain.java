package com.sangeun.teamf.dto;

import lombok.*;

import javax.persistence.*;
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class Complain {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int complainNum;

    @Column(nullable = false)
    @Enumerated(EnumType.STRING)
    private ComplainType complainType;

    @Lob
    @Column(nullable = false)
    private String complainContent;

    private int indemnity;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="orderNum")
    private OrderBean orderBean;

}
