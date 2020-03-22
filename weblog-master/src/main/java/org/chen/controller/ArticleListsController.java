package org.chen.controller;

import com.github.pagehelper.PageInfo;
import org.chen.bean.article;
import org.chen.service.ArticleListsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.Mapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/article")
public class ArticleListsController {
    @Autowired
    private ArticleListsService articleListsService;


    @GetMapping("/articleLists")
    public ResponseEntity<PageInfo<article>> getallarticleLists(
            @RequestParam(value = "querykey",required = false) String querykey,
            @RequestParam(value = "pagesize",defaultValue = "1") Integer pagesize,
            @RequestParam(value = "pagenumber",defaultValue = "5") Integer pagenumber

    ){
        //分页助手包装
       PageInfo<article> articleList= this.articleListsService.getallarticleLists(querykey,pagesize,pagenumber);

       return ResponseEntity.ok(articleList);
    }
//废弃
    @GetMapping("/getCountArticle")
    public ResponseEntity<Integer> getCountArticle(){
        Integer num= this.articleListsService.getCountArticle();
       return ResponseEntity.ok(num);
    }

    @GetMapping("/deletearticle")
    public ResponseEntity<Integer> deletearticle(@RequestParam Integer id){
       Integer code= this.articleListsService.deletearticle(id);
       if (code==1){
           return ResponseEntity.ok(code);
       }
       return (ResponseEntity<Integer>) ResponseEntity.notFound();
    }
}
