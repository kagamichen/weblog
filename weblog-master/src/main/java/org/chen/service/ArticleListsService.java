package org.chen.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.chen.bean.article;
import org.chen.mapper.ArticleListsMapper;
import org.chen.mapper.Article_columnMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ArticleListsService {
    @Autowired
    private ArticleListsMapper articleListsMapper;

    @Autowired
    private Article_columnMapper article_column;

    public PageInfo<article> getallarticleLists(String querykey,Integer pagesize,Integer pagenumber) {

        PageHelper.startPage(pagenumber,pagesize);
        List<article> articleList= this.articleListsMapper.selectallarticle(querykey);
        //通过id获取栏目名
        articleList.forEach(list->{

           String name= this.article_column.selectcolumnbycid(list.getColumn_id());
            list.setColumn(name);
        });
        PageInfo<article> pageInfo=new PageInfo<article>(articleList);

        return pageInfo;
    }

    public Integer getCountArticle( ) {
       Integer num= this.articleListsMapper.getCountArticle();
        return num;
    }

//根据id删除对应的文章
    public Integer deletearticle(Integer id) {
       Integer code= this.articleListsMapper.deletearticle(id);

       return code;
    }
}
