package org.chen.service;


import org.chen.bean.Login;
import org.chen.mapper.LoginMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LoginService {
    @Autowired
    private LoginMapper loginMapper;


    /**
     * 查询用户名和密码
     * @param login
     */
    public Integer loginSelcet(Login login) {
        Integer logininter = this.loginMapper.wherelogin(login.getUsername(),login.getPassword());

      return logininter;
    }
}
