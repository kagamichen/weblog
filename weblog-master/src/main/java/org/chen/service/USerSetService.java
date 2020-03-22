package org.chen.service;

import org.chen.bean.Role;
import org.chen.bean.User;
import org.chen.bean.Userset;
import org.chen.mapper.UserSetMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.beans.Transient;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class USerSetService {
    @Autowired
    UserSetMapper userSetMapper;

    public List<Userset> getAllUserSet() {

        return this.userSetMapper.getAllUserSet();
    }

    public Map<String, Object> deleteUser(Integer id) {
        HashMap<String, Object> map = new HashMap<>();
        try {
            Integer integer = this.userSetMapper.deleteUser(id);
            if (integer > 0) {
                map.put("msg", "删除成功");
                map.put("code", integer);
            } else {
                map.put("msg", "删除失败");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return map;
    }

    //获取role表 namezh
    public List<Role> getAuthoritys() {
        List<Role> roles = this.userSetMapper.getAuthoritys();
        return roles;
    }

    /**
     *
     * @param username
     * @param password
     * @param realname
     * @param phone
     * @param authority
     * @return
     */
    @Transactional
    public Map<String, Object> register(String username, String password, String realname, String phone, Integer authority) {
        try {
            HashMap<String, Object> map = new HashMap<>();
            Userset user1 = this.userSetMapper.selectUser(username);
            if(user1!=null){
                map.put("msg", "用户名重复");
                return map;
            }
            Integer id = this.userSetMapper.register(username, password, realname, phone, authority);
            Userset user = this.userSetMapper.selectUser(username);
            Integer value2 = this.userSetMapper.registerRole(authority, user.getId());
            if (id > 0 && value2 > 0) {
                map.put("msg", "注册成功");
            } else {
                map.put("msg", "注册失败");
            }
            return map;
        } catch (Exception e) {
            throw e;
        }

    }
}
