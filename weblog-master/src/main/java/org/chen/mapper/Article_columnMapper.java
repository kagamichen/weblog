package org.chen.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.chen.bean.article_column;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Mapper
@Repository
public interface Article_columnMapper {
    @Select("select * from article_column where cid=#{column_id}")
    String selectcolumnbycid(Integer column_id);

    @Select("select * from article_column ")
    List<article_column> getAllcolumn();
    @Insert("INSERT into article_column(`column`,updatetime) VALUES(#{column},#{date}) ")
    Integer addcolumn(String column, Date date);
    @Delete("DELETE FROM article_column WHERE cid=#{cid}")
    Integer deletecolumn(Integer cid);
    @Delete("DELETE FROM article WHERE column_id=#{cid}")
    Integer deleteArticleByColumn(Integer cid);
}
