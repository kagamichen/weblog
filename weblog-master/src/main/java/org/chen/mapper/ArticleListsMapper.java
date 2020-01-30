package org.chen.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.chen.bean.article;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Mapper
@Repository
public interface ArticleListsMapper {
    @Select("select * from article where title like '%${querykey}%'")
    List<article> selectallarticle( String querykey);


    @Select("select count(*) from article ")
    Integer getCountArticle( );


    @Insert("INSERT into article(Title,CreationTime,Author,Column_id,Body) VALUES(#{title},#{creationtime},#{author},#{column_id},#{body})")
    Integer insertArticle(String title,Date creationtime,String author,Integer column_id,String body);

    @Delete("DELETE FROM article WHERE id=#{id}")
    Integer deletearticle(Integer id);


    @Select("SELECT Title FROM article where id= #{aid}")
    String selectallarticlebyid(Integer aid);

     @Select("select * from article where Column_id=#{column_id}")
    List<article> findtitlebyid(Integer column_id);
}
