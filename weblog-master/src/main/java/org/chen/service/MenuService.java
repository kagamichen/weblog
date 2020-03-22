//package org.chen.service;
//
//import org.chen.bean.Menu;
//import org.chen.bean.User;
//import org.chen.mapper.MenuMapper;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.stereotype.Service;
//
//import java.util.List;
//
//@Service
//public class MenuService {
//    @Autowired
//    MenuMapper menuMapper;
//
//    public List<Menu> getMenusById() {
//        //获取登陆用户id（内存）
//        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
////        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//          User user= (User) principal;
//        return menuMapper.getMenusByUserId(user.getId());
//    }
//}
