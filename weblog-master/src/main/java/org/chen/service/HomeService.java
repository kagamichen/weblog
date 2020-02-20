package org.chen.service;

import org.chen.bean.Nav;
import org.chen.bean.Nav_second;
import org.chen.mapper.NavMapper;
import org.chen.mapper.Nav_secondMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sun.tools.tree.ThisExpression;

import java.util.List;

@Service
public class HomeService {
    @Autowired
    private NavMapper navMapper;

    @Autowired
    private Nav_secondMapper nav_secondMapper;

    /**
     *  取一，二级导航栏
     * @return
     */
    public List<Nav> selectListNav() {
     List<Nav> navList=  this.navMapper.selectNav();
        System.out.println(navList);
        navList.forEach(nav -> {
        //  根据一级导航栏的id，去除二级导航栏的信息
       List<Nav_second> nav_seconds = this.nav_secondMapper.selectByNavId(nav.getNav_id());
       nav.setNav_secondList(nav_seconds);
        });
        return navList;
    }
}
