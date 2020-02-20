package org.chen.service;

import org.chen.bean.article_column;
import org.chen.mapper.Article_columnMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class Columnservice {
    @Autowired
    private Article_columnMapper article_columnMapper;




    public String addcolumn(String column, Date date) {
       Integer num= this.article_columnMapper.addcolumn(column,date);
       if (num==1){
           return "添加成功";
       }
      else {
          return "错误";
       }
    }

    public Integer deletecolumn(Integer cid) {
      Integer temp=  this.article_columnMapper.deletecolumn(cid);
      if (temp==1){
          return temp;
      }
      return null;
    }
}
