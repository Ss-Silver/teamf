package com.sangeun.teamf.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;

import javax.persistence.*;
import java.util.List;

@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class Voc {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int vocNum;

    @ManyToOne(fetch = FetchType.LAZY
    )
    @JoinColumn(name="complainNum")
    private Complain complain;    //컴플레인 내용

    @Enumerated(EnumType.STRING)
    private RoleType responsibility;  //귀책 당사자

    @Column(nullable = false)
    private String causes;  //귀책 배정사유 사유(귀책 내용)

    private String penalty; //패널티 내용

    @ManyToOne(fetch = FetchType.LAZY)
    private User admin; //작성 담당자

    private Boolean chkDriver;  //기사/운송사 확인 유무
    private Boolean appeal; //기사/운송사 이의제기 유무

    @Enumerated(EnumType.STRING)
    private VocProgress vocProgress;
    // VOC진행상태 : 등록(ENROLL), 기사확인(DRICHK), 기사인정(CONFIRM), 이의신청(APPEAL), 고객승인(CLICONFIRM), 종료(END)

    @OneToMany(mappedBy="voc", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JsonIgnoreProperties({"voc"})
    private List<Compensation> compensation;

    //@OneToMany(fetch = FetchType.EAGER,mappedBy = "voc", cascade = CascadeType.ALL)
    //@JsonIgnoreProperties({"voc"})
    //private List<Appeal> appeals;


}
