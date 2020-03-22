package org.chen.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.chen.bean.Role;
import org.chen.bean.User;
import org.chen.bean.Userset;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface UserSetMapper {

    public List<Userset> getAllUserSet();

    Integer deleteUser(Integer id);

    List<Role> getAuthoritys();

    Integer register(String username, String password, String realname, String phone, Integer authority);

    Userset selectUser(String username);

    Integer registerRole(Integer authority, Integer id);
}
