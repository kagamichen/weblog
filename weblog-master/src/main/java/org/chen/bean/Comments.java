package org.chen.bean;

import java.util.Date;
//评论表
public class Comments {
    private Integer pid;//评论的id
    private Integer aid;//文章id
    private Date Commenttime;//
    private String content;
    private String user;//评论用户

    //额外添加的字段
    private String title;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getAid() {
        return aid;
    }

    public void setAid(Integer aid) {
        this.aid = aid;
    }

    public Date getCommenttime() {
        return Commenttime;
    }

    public void setCommenttime(Date commenttime) {
        Commenttime = commenttime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
