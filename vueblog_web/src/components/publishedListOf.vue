<template>
  <div>
  <!--      面包屑-->
  <el-breadcrumb separator="/">
    <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
    <el-breadcrumb-item>文章管理</el-breadcrumb-item>
    <el-breadcrumb-item>发表列表</el-breadcrumb-item>
  </el-breadcrumb>


<!--白色卡片区域-->
    <el-card class="box-card body-card">
<!--    表单区域-->
    <el-form ref="form" :model="form" label-width="80px">
      <el-row :gutter="30">
<!--        布局-->
        <el-col :span="5">
          <el-form-item label="所属栏目">
<!--            选择器-->
            <el-select v-model="form.column_id" class="choose">
              <el-option
                v-for="item in options"
                :key="item.cid"
                :label="item.column"
                :value="item.cid">
              </el-option>
            </el-select>
          </el-form-item>

        </el-col>

        <el-col :span="6">
      <el-form-item label="文章标题">
        <el-input v-model="form.title"></el-input>
      </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="作者">
            <el-input v-model="form.author"></el-input>
          </el-form-item>
        </el-col>

        <el-col :span="5">
        <!--      //提交按钮-->
        <el-form-item >
          <el-button type="primary" @click="postarticle()">提交文章<i class="el-icon-upload el-icon--right"></i></el-button>
        </el-form-item>
        </el-col>
      </el-row>
      <el-form-item label="正文">
<!--        富文本编辑器-->
        <Editor v-model="form.body"  ref="wangE"/>
        <button v-on:click="getContentt()" >测试</button>
      </el-form-item>

    </el-form>
    </el-card>
  </div>
</template>

<script>
  import { getRequest, postRequest } from '../utils/app'
  // import wangEditor from "../components/other/Editor"
import Editor from './other/Editor'
  export default {
    components: {
      Editor
    },

    data() {
      return {
        form: {
          column_id:'',
          title:'',
          author:'',
          body:'',
        },
        options: [],
        column: '',
        editorContent: '',

      }
    },

    created () {
      //获取所有栏目
      this.getcolumn();
    },
    methods: {

      //获取所有栏目
     async getcolumn(){
       const {data:res}= await getRequest("submit/getcolumn")
        // console.log(res);
       this.options=res;
      },
      //上传文章
    async  postarticle(){
        // console.log(this.form)
      this.form.body=this.$refs.wangE.getHtml();
      const respon=await this.$http.post("submit/insertArticle",this.form)
        // console.log(respon)
      if (respon.status===200){
        this.$message.success("文章提交成功");
        return ;
      }
      this.$message.error("服务器错误，请稍后再试")
      },
      getContentt(){

      }
    }
  }
</script>

<style scoped>


</style>
