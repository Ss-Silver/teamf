package com.sangeun.teamf.repository;

import com.sangeun.teamf.dto.OrderBean;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface OrderRepository extends JpaRepository<OrderBean, Integer> {

    @Query(value="SELECT o.* FROM orderBean AS o LEFT JOIN User AS u ON\n" +
            "o.clientNum = u.userNum WHERE o.clientNum = ? ORDER BY o.orderNum DESC", nativeQuery = true)
    List<OrderBean> cOrderList(int userNum);

    @Query(value="SELECT o.* FROM orderBean AS o LEFT JOIN User AS u ON\n" +
            "o.driverNum = u.userNum WHERE o.driverNum = ? ORDER BY o.orderNum DESC", nativeQuery = true)
    List<OrderBean> dOrderList(int userNum);

    @Query(value = "SELECT o.* FROM orderBean AS o LEFT JOIN User AS u ON\n" +
            "o.clientNum = u.usernum WHERE o.progress = 'CLAIM' ORDER BY o.orderNum DESC", nativeQuery = true)
    List<OrderBean> complainList();

}
