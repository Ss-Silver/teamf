package com.sangeun.teamf.service;

import com.sangeun.teamf.dto.User;
import com.sangeun.teamf.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service //스프링이 컴포넌트 스캔을 통해서 Bean에 등록을 해줌(IoC를 해준다)
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Transactional
    public void write(User user) {
        userRepository.save(user);
    }

    public String idCheck(String userId) {
        User user = userRepository.findByUserId(userId);
        String cnt ="0";
        if(user != null) {
            cnt = "1";
            return cnt;
        }
        return cnt;
    }


    @Transactional(readOnly = true)
    public User login(User user) {
        return userRepository.findByUserIdAndPassword(user.getUserId(), user.getPassword());
    }
}
