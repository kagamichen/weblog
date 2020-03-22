package org.chen.controller;

import org.chen.bean.article_column;
import org.chen.service.Columnservice;
import org.chen.service.PublishedListOfService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/column")
public class ColumnController {
    @Autowired
    private Columnservice columnservice;
    @Autowired
    private PublishedListOfService publishedListOfService;

    /**
     * 获取article_column 表的所有list
     * @return
     */
    @GetMapping("/getcolumn")
    public ResponseEntity<List<article_column>> getAllcolumn(){
        List<article_column> lists= this.publishedListOfService.getAllcolumn();

        return ResponseEntity.ok(lists);
    }


    /**
     * 通过栏目名字 添加栏目信息
     * @param column
     * @return
     */
    @GetMapping("/addcolumn")
    public ResponseEntity<String> addcolumn(@RequestParam String column){
        Date date = new Date();
        String temp= this.columnservice.addcolumn(column,date);
        return ResponseEntity.ok(temp);
    }
    @GetMapping("/deletecolumn")
    public ResponseEntity<String> deletecolumn(@RequestParam Integer cid){
       Integer temp= this.columnservice.deletecolumn(cid);
       if (temp==1){
         return   ResponseEntity.ok("删除成功");
       }else {
           return ResponseEntity.notFound().build();
       }
    }

}
