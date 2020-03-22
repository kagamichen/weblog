package org.chen.controller;

import org.chen.bean.User;
import org.chen.bean.Userset;
import org.chen.service.USerSetService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/userset")
public class UsersetController {
    @Autowired
    USerSetService uSerSetService;

    /**
     * 获取所有的用户信息
     * @return
     */
    @GetMapping("/getAllUserSet")
    public ResponseEntity<List<Userset>> getAllUserSet() {
     List<Userset> allUserSet= this.uSerSetService.getAllUserSet();
        return ResponseEntity.ok(allUserSet);
    }

    /**
     * 删除账号
     * @param id
     * @return
     */
    @GetMapping("/deleteUser")
    public ResponseEntity<Map<String,Object>> deleteUser(@RequestParam Integer id){
       Map<String,Object> map= this.uSerSetService.deleteUser(id);
       return ResponseEntity.ok(map);
    }



}
