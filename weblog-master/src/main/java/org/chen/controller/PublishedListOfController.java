package org.chen.controller;

import org.chen.bean.article;
import org.chen.bean.article_column;
import org.chen.mapper.Article_columnMapper;
import org.chen.service.PublishedListOfService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;

@Controller
public class PublishedListOfController {
    @Autowired
    private PublishedListOfService publishedListOfService;

    /**
     * 获取article_column 表的所有list
     * @return
     */
    @GetMapping("getcolumn")
    public ResponseEntity<List<article_column>> getAllcolumn(){
       List<article_column> lists= this.publishedListOfService.getAllcolumn();

        return ResponseEntity.ok(lists);
    }

    /**
     * 获取文章详细信息 添加到数据库
     * @param article
     * @return
     */
    @PostMapping("insertArticle")
    public ResponseEntity<String> insertArticle(@RequestBody article article){
        System.out.println(article.toString());
      Integer integer=  this.publishedListOfService.insertArticle(article);
      if (integer==1) {
          return ResponseEntity.ok("更新成功");
      }
       return (ResponseEntity<String>) ResponseEntity.notFound();
    }
}
