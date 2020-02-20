package org.chen.bean;

import java.util.Date;

public class article {
    private Integer id;
    private String title;
    private Date creationtime;
    private String author;
    private  Integer column_id;
    private  String body;
      private String column;//额外添加的字段

    public String getColumn() {
        return column;
    }

    public void setColumn(String column) {
        this.column = column;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getCreationtime() {
        return creationtime;
    }

    public void setCreationtime(Date creationtime) {
        this.creationtime = creationtime;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Integer getColumn_id() {
        return column_id;
    }

    public void setColumn_id(Integer column_id) {
        this.column_id = column_id;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }
}
