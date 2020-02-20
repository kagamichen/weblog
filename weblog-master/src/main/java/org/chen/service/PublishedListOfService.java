package org.chen.service;

import org.chen.bean.article;
import org.chen.bean.article_column;
import org.chen.mapper.ArticleListsMapper;
import org.chen.mapper.Article_columnMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class PublishedListOfService {

    @Autowired
    private Article_columnMapper article_columnMapper;

    @Autowired
    private ArticleListsMapper article;

    public List<article_column> getAllcolumn() {
       List<article_column> lists= this.article_columnMapper.getAllcolumn();
        return lists;
    }


    public Integer insertArticle(article article) {
        article.setCreationtime(new Date());
        Integer integer = this.article.insertArticle
                (article.getTitle(),article.getCreationtime(),article.getAuthor(),article.getColumn_id(),article.getBody());
        System.out.println(integer);
        return integer;
    }
}
