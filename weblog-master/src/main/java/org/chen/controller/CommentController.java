package org.chen.controller;

import org.chen.bean.Comments;
import org.chen.bean.Article;
import org.chen.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

//评论相关
@Controller
@RequestMapping("/comment")
public class CommentController {


    @Autowired
    private CommentService commentService;

    /**
     * 获取评论
     * @return
     */
    @GetMapping("/getcomment")
    public ResponseEntity<List<Comments>> getcomments(
            @RequestParam (value = "aid",required = false)Integer aid
    )
    {
        List<Comments> lists=null;
        lists=this.commentService.getcomments(aid);
        return ResponseEntity.ok(lists);
    }

    /**
     * 根据栏目id获取文章
     * @param column_id
     * @return
     */
    @GetMapping("/getarticleselect")
    public ResponseEntity<List<Article>> getarticleBycolumnid(@RequestParam (value = "column_id",required = false) Integer column_id){

        List<Article> names=  this.commentService.getarticleBycolumnid(column_id);
      return ResponseEntity.ok(names);
    }

    @GetMapping("/AddComment")
    public ResponseEntity<Map<String,Object>> AddComment(
            @RequestParam(value = "comment",required = false) String comment,
            @RequestParam(value = "aid",required = false) Integer aid,
            @RequestParam(value = "CommentUser",required = false) String CommentUser
    ){
        HashMap<String, Object> map = new HashMap<>();
      map= commentService.addComment(comment,aid,CommentUser);
        return  ResponseEntity.ok(map);
    }

    @GetMapping("/deleteComment")
    public ResponseEntity<Map<String,Object>> deleteCommentById(@RequestParam(value = "commentId",defaultValue = "0") Integer pid){
        HashMap<String, Object> map = new HashMap<>();
       map= this.commentService.deleteCommentById(pid);
        return ResponseEntity.ok(map);

    }
}
