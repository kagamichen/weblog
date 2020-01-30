package org.chen.controller;


import org.chen.bean.Login;
import org.chen.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class LoginController {
    @Autowired
    private LoginService loginService;


    /**
     * 登录请求
     * @param
     * @return
     */
   @PostMapping("login")
    public ResponseEntity<Map<String,Object>> findLoginInfo(@RequestBody Login loginForm){

       Integer loginBoolean= this.loginService.loginSelcet(loginForm);
       HashMap<String, Object> loginMap = new HashMap<>();
       if (loginBoolean==0){
//     return ResponseEntity.notFound().build();
           loginMap.put("msg","失败");
           return new ResponseEntity<Map<String,Object>>(loginMap,HttpStatus.OK);
       }
       loginMap.put("msg","成功");

       return new ResponseEntity<Map<String,Object>>(loginMap,HttpStatus.OK);
   }




}
