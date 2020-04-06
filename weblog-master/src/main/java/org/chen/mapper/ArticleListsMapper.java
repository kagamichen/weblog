package org.chen.mapper;

import org.apache.ibatis.annotations.*;
import org.chen.bean.Article;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Mapper
@Repository
public interface ArticleListsMapper {
    @Select("select * from article where title like '%${querykey}%'")
    List<Article> selectallarticle(String querykey);


    @Select("select count(*) from article ")
    Integer getCountArticle( );


    @Insert("INSERT into article(Title,CreationTime,Author,Column_id,Body) VALUES(#{title},#{creationtime},#{author},#{column_id},#{body})")
    Integer insertArticle(String title,Date creationtime,String author,Integer column_id,String body);

    @Delete("DELETE FROM article WHERE id=#{id}")
    Integer deletearticle(Integer id);


    @Select("SELECT Title FROM article where id= #{aid}")
    String selectallarticlebyid(Integer aid);

     @Select("select * from article where Column_id=#{column_id}")
    List<Article> findtitlebyid(Integer column_id);
//    @Select("select * from article where id=#{id} ")
    @Select("SELECT * FROM article LEFT JOIN article_column ON article.column_id=article_column.cid WHERE article.id=#{id} ")
    Article getArticleById(Integer id);

    @Update("UPDATE article SET title=#{title},creationtime=#{creationtime},author=#{author},column_id=#{column_id},body=#{body} WHERE id=#{id}")
    void upArticle(Integer id,String title, Date creationtime, String author, Integer column_id, String body);
}
