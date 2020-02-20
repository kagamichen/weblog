package org.chen.mapper;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.chen.bean.Comments;
import org.springframework.stereotype.Repository;
import java.util.List;





@Mapper
@Repository
public interface CoomentsMapper {


    @Select("select * from comments where aid=#{aid}")

    List<Comments> getcomments(Integer aid);
}
