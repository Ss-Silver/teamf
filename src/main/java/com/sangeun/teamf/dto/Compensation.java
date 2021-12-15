package com.sangeun.teamf.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;

import javax.persistence.*;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class Compensation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int compensationNum;

    @Column(nullable = false)
    private int realIndemnity;

    private int pastIndemnity;

    @ManyToOne
    @JoinColumn(name = "userNum")
    private User user; //배상 작성자

    @ManyToOne(cascade = {CascadeType.ALL})
    @JoinColumn(name = "vocNum")
    private Voc voc; //Voc정보

    @OneToMany(mappedBy = "compensation", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JsonIgnoreProperties({"compensation"})
    private List<Appeal> appeal;

}
