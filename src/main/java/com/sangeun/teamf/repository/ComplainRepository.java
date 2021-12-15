package com.sangeun.teamf.repository;

import com.sangeun.teamf.dto.Complain;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ComplainRepository extends JpaRepository<Complain, Integer> {
}
