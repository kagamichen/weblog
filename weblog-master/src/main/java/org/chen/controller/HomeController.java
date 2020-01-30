package org.chen.controller;

import org.chen.bean.Nav;
import org.chen.service.HomeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private HomeService homeService;

    /**
     * 动态渲染home界面的导航栏
     * @return
     */
    @GetMapping("home")
    public ResponseEntity<List<Nav>> findNav(){
       List<Nav> navList= this.homeService.selectListNav();
        return ResponseEntity.ok(navList);

    }
}
