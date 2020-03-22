package org.chen.controller;

import org.chen.bean.Role;
import org.chen.service.USerSetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/userRegister")
public class userRegisterController {
    @Autowired
    USerSetService uSerSetService;

    /**
     * 获取role表信息
     * @return
     */
    @GetMapping("/getAuthoritys")
    public ResponseEntity<List<Role>> getAuthoritys (){
       List<Role> roles= this.uSerSetService.getAuthoritys();
       return ResponseEntity.ok(roles);
    }

    /**
     * 实现注册功能
     * @param username
     * @param password
     * @param realname
     * @param phone
     * @param Authority
     * @return
     */
    @PostMapping("/register")
    public ResponseEntity<Map<String,Object>> register(
            @RequestParam(value = "username",required = false) String username,
            @RequestParam(value = "password",required = false) String password,
            @RequestParam(value = "realname",required = false) String realname,
            @RequestParam(value = "phone",required = false) String phone,
            @RequestParam(value = "Authority",required = false) Integer Authority

    ){
        System.out.println(username+"-"+password+"-"+realname+"-"+phone+"-"+Authority);
       Map<String,Object> map= this.uSerSetService.register(username,password,realname,phone,Authority);
        return ResponseEntity.ok(map);
    }
}
