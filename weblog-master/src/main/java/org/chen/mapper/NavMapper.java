package org.chen.mapper;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.chen.bean.Nav;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface NavMapper {

   @Select("select * from nav")
   List <Nav> selectNav();
}
