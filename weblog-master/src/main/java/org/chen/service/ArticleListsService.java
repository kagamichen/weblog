package org.chen.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.chen.bean.Article;
import org.chen.mapper.ArticleListsMapper;
import org.chen.mapper.Article_columnMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

@Service
public class ArticleListsService {
    @Autowired
    private ArticleListsMapper articleListsMapper;

    @Autowired
    private Article_columnMapper article_column;

    public PageInfo<Article> getallarticleLists(String querykey, Integer pagesize, Integer pagenumber) {
        //分页助手设置页数，页码
        PageHelper.startPage(pagenumber,pagesize);
        //获取全部数组Article
        List<Article> articleList= this.articleListsMapper.selectallarticle(querykey);
        //通过数组id查询对应的栏目名，添加进相应的栏目名
        articleList.forEach(list->{
           String name= this.article_column.selectcolumnbycid(list.getColumn_id());
            list.setColumn(name);
        });
        //分页助手根据页数，页码返回数组
        PageInfo<Article> pageInfo=new PageInfo<Article>(articleList);
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
//根据id查找文章
    public Article getArticleById(Integer id) {
        Article article=this.articleListsMapper.getArticleById(id);
        return article;
    }

    public HashMap<String, Object> upArticle(Article article) {
        HashMap<String, Object> map = new HashMap<String, Object>();

        try {
            article.setCreationtime(new Date());
            this.articleListsMapper.upArticle(article.getId(),article.getTitle(),article.getCreationtime(),article.getAuthor(),article.getColumn_id(),article.getBody());
            map.put("msg","修改文章成功");
        }catch (Exception e){
            map.put("msg","修改文章失败");
        }finally {
            return map;
        }

    }
}
