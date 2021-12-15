package com.sangeun.teamf.repository;


import com.sangeun.teamf.dto.Voc;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface VocRepository extends JpaRepository<Voc, Integer> {

    // complainNum, orderNum 각 테이블의 연관관계인 PK, FK이다.
    // 하지만 쿼리문 작성시 컬럼이름간 모호성이 있어서 에러가 발생하였다.
    // 우선은 해결방법을 찾지 못하여 JSTL에서 조건문을 사용하여 선택적 리스트를 출력하고자 한다.
    @Query(value = "SELECT V.*, C.*, O.*\n" +
            "FROM Voc AS V \n" +
            "\t LEFT OUTER JOIN Complain AS C ON v.complainNum = C.complainNum \n" +
            "    LEFT OUTER JOIN OrderBean AS O ON C.orderNum = O.orderNum \n" +
            "    WHERE clientNum = ?1", nativeQuery = true)
    List<Object> cVocList(int clientNum);
}
