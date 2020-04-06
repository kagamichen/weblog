package org.chen.controller;

import com.github.pagehelper.PageInfo;
import org.chen.bean.Article;
import org.chen.service.ArticleListsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/article")
public class ArticleListsController {
    @Autowired
    private ArticleListsService articleListsService;


    @GetMapping("/articleLists")
    public ResponseEntity<PageInfo<Article>> getallarticleLists(
            @RequestParam(value = "querykey",required = false) String querykey,
            @RequestParam(value = "pagesize",defaultValue = "1") Integer pagesize,
            @RequestParam(value = "pagenumber",defaultValue = "5") Integer pagenumber

    ){
        //分页助手包装
       PageInfo<Article> articleList= this.articleListsService.getallarticleLists(querykey,pagesize,pagenumber);

       return ResponseEntity.ok(articleList);
    }
//废弃
    @GetMapping("/getCountArticle")
    public ResponseEntity<Integer> getCountArticle(){
        Integer num= this.articleListsService.getCountArticle();
       return ResponseEntity.ok(num);
    }

    /**
     * 根据id删除文章
     * @param id
     * @return
     */
    @GetMapping("/deletearticle")
    public ResponseEntity<Integer> deletearticle(@RequestParam Integer id){
       Integer code= this.articleListsService.deletearticle(id);
       if (code==1){
           return ResponseEntity.ok(code);
       }
       return (ResponseEntity<Integer>) ResponseEntity.notFound();
    }

    /**
     * 根据文章id来查询文章信息以及所在栏目
     * @param id
     * @return
     */
    @GetMapping("/getArticleById")
    public ResponseEntity<Article> getArticleById(@RequestParam Integer id){
        Article article=this.articleListsService.getArticleById(id);
        return ResponseEntity.ok(article);
    }

    @PostMapping("/upArticle")
    public ResponseEntity<Map<String,Object>> upArticle(@RequestBody Article article){
        HashMap<String, Object> map = new HashMap<String, Object>();
        map= this.articleListsService.upArticle(article);
        return ResponseEntity.ok(map);
    }
}
