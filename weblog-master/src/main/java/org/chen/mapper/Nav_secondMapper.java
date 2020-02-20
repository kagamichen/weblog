package org.chen.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.chen.bean.Nav_second;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface Nav_secondMapper {


    @Select("select * from Nav_second where nav_id=#{nav_id}")
    List<Nav_second> selectByNavId(Integer nav_id);
}
