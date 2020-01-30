package org.chen.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import org.chen.bean.Login;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface LoginMapper {


    @Select("select count(*) from login where username=#{username} and password=#{password}")
    Integer wherelogin(String username, String password);


}
