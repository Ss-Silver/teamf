package com.sangeun.teamf.repository;

import com.sangeun.teamf.dto.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Integer> {

    User findByUserIdAndPassword(String userId, String password);

    User findByUserId(String userId);

    User findByUserNum(int userNum);
}
