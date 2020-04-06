package org.chen.service;

import org.chen.bean.Comments;
import org.chen.bean.Article;
import org.chen.mapper.ArticleListsMapper;
import org.chen.mapper.CoomentsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service
public class CommentService {
    @Autowired
    private CoomentsMapper coomentsMapper;
    @Autowired
    private ArticleListsMapper articleListsMapper;

    /**
     * 获取所有评论，如果有传入文章id，根据文章id 查询
     * @param aid
     * @return
     */
    public List<Comments> getcomments(Integer aid) {
       List<Comments> lists=null;
     if (null==aid){
       lists=this.coomentsMapper.getAllcomments();
     }else {
         lists=this.coomentsMapper.getcomments(aid);
     }

         //根据评论id 查找对应的文章标题
        lists.forEach(list->{
         String title=  this.articleListsMapper.selectallarticlebyid(list.getAid());
         list.setTitle(title);
        });
        return  lists;
    }

    /**
     * 传入栏目id 来查找 文章信息
     * @param column_id
     * @return
     */

    public List<Article> getarticleBycolumnid(Integer column_id) {
        List<Article> titles=this.articleListsMapper.findtitlebyid(column_id);
        return titles;
    }

    /**
     *根据传入的信息判断返回键值对
     * @param comment
     * @param aid
     * @param CommentUser
     * @return
     */
    public HashMap<String, Object> addComment(String comment, Integer aid,String CommentUser) {
        HashMap<String, Object> map = new HashMap<>();
        if (null == aid){
            map.put("msg","请选择对应的文章");
            return map;
        }else if ("".equals(CommentUser) ){
        map.put("msg","请输入评论用户名");
           return map;
        }else if ("".equals(comment)){
            map.put("msg","请输入评论");
            return map;
        }
        Date date = new Date();
        try {
            this.coomentsMapper.addComment(comment,aid,CommentUser,date);
            map.put("msg","添加成功");
        }catch (Exception e){
            map.put("msg","添加失败，请检查服务器");
        }finally {
            return map;
        }

    }

    public HashMap<String, Object> deleteCommentById(Integer pid) {
        HashMap<String, Object> map = new HashMap<>();
        if ("0".equals(pid)){
            map.put("msg","删除错误，请正确的删除");
            return map;
        }else {
            try {
                this.coomentsMapper.deleteCommentById(pid);
                map.put("msg","删除成功");
            }catch (Exception e){
                map.put("msg","删除失败，请重试");
            }finally {
                return map;
            }
        }
    }
}
