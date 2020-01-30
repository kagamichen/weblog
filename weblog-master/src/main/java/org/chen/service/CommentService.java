package org.chen.service;

import org.chen.bean.Comments;
import org.chen.bean.article;
import org.chen.mapper.ArticleListsMapper;
import org.chen.mapper.CoomentsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

        List<Comments> lists=this.coomentsMapper.getcomments(aid);

        lists.forEach(list->{
         String title=  this.articleListsMapper.selectallarticlebyid(list.getAid());
         list.setTitle(title);
        });
        return  lists;
    }

    /**
     * 传如栏目id 来查找 文章信息
     * @param column_id
     * @return
     */

    public List<article> getarticleBycolumnid(Integer column_id) {
        List<article> titles=this.articleListsMapper.findtitlebyid(column_id);
        return titles;
    }
}
