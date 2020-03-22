//package org.chen.controller;
//
//import org.chen.bean.Menu;
//import org.chen.service.MenuService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import java.util.List;
//
//@Controller
//@RequestMapping("/security")
//public class SecurityConfigController {
//    @Autowired
//    MenuService menuService;
//    @GetMapping("/menu")
//  public ResponseEntity<List<Menu>> getMenusById(){
//
//          List<Menu> menus= this.menuService.getMenusById();
//        return ResponseEntity.ok(menus);
//  }
//}
