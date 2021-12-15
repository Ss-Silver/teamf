package com.sangeun.teamf.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;

import javax.persistence.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
public class Appeal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int AppealNum;

    @Column(nullable = false)
    private String Title;

    @Column(nullable = false)
    private String Content;

    private int past;

    private int renew;

    @ManyToOne
    @JsonIgnoreProperties({"compensation"})
    private Compensation compensation;
}
