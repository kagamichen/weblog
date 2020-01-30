package org.chen.controller;

import org.chen.bean.Comments;
import org.chen.bean.article;
import org.chen.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
//评论相关
@Controller
public class CommentController {


    @Autowired
    private CommentService commentService;

    /**
     * 获取评论
     * @return
     */
    @GetMapping("getcomment")
    public ResponseEntity<List<Comments>> getcomments(
            @RequestParam (value = "aid",required = false)Integer aid
    )
    {
        List<Comments> lists=this.commentService.getcomments(aid);
        return ResponseEntity.ok(lists);
    }

    @GetMapping("getarticleselect")
    public ResponseEntity<List<article>> getarticleBycolumnid(
            @RequestParam Integer column_id
    ){
      List<article> names=  this.commentService.getarticleBycolumnid(column_id);
      return ResponseEntity.ok(names);
    }
}
