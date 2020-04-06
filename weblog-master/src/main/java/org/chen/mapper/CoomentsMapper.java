package org.chen.mapper;


import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.chen.bean.Comments;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;





@Mapper
@Repository
public interface CoomentsMapper {


    @Select("select * from comments where aid=#{aid}")
    List<Comments> getcomments(Integer aid);
    @Select("select * from comments")
    List<Comments> getAllcomments();

    @Insert("INSERT INTO Comments(aid,Commenttime,content,user) VALUES(#{aid},#{date},#{comment},#{commentUser})")
    void addComment(String comment, Integer aid, String commentUser, Date date);
    @Delete("DELETE FROM Comments WHERE pid=#{pid}")
    void deleteCommentById(Integer pid);
}
