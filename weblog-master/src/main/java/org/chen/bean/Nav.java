package org.chen.bean;

import java.util.List;

public class Nav {
    private Integer nav_id;
    private String nav_name;

    private List<Nav_second> nav_secondList;

    public Integer getNav_id() {
        return nav_id;
    }

    public void setNav_id(Integer nav_id) {
        this.nav_id = nav_id;
    }

    public String getNav_name() {
        return nav_name;
    }

    public void setNav_name(String nav_name) {
        this.nav_name = nav_name;
    }

    public List<Nav_second> getNav_secondList() {
        return nav_secondList;
    }

    public void setNav_secondList(List<Nav_second> nav_secondList) {
        this.nav_secondList = nav_secondList;
    }
}
