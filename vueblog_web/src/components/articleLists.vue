<template>
  <div>
    <!--      面包屑-->
    <el-breadcrumb separator="/">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>文章管理</el-breadcrumb-item>
      <el-breadcrumb-item>文章列表</el-breadcrumb-item>
    </el-breadcrumb>
    <!--卡片区域-->
    <el-card class="box-card body-card" >
      <!--        搜索栏-->
      <el-row :gutter="20">
        <el-col :span="10">
          <div>
            <el-input v-model="queryinfo.querykey" class="input-with-select" placeholder="请输入标题来搜索文章">
              <el-button @click="getArticle" icon="el-icon-search" slot="append"/>
            </el-input>
          </div>
        </el-col>

      </el-row>
<!--      表格-->
      <el-table
        :data="articlelist"
        border
        stripe
        style="width: 100%">
        <el-table-column
          prop="id"
        label="序号"
          width="180">
        </el-table-column>
        <el-table-column
          label="日期"
          prop="creationtime"
          width="180">
        </el-table-column>
        <el-table-column
          label="作者"
          prop="author"
          width="180">
        </el-table-column>
        <el-table-column
          label="标题"
          prop="title"
          width="180">
        </el-table-column>
        <el-table-column
          label="栏目"
          width="180"
          prop="column">
        </el-table-column>
        <el-table-column
          label="操作"
         >
          <template slot-scope="scope">
            <el-button type="primary" icon="el-icon-edit" @click="updatearticle(scope.row.id)">编辑</el-button>
            <el-button type="danger" icon="el-icon-delete" @click="deletearticleopen (scope.row.id)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
<!--      分页栏-->

      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="queryinfo.pagenumber"
        :page-sizes="[1, 3, 5, 20]"
        :page-size="5"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total">
      </el-pagination>
    </el-card>

<!--    修改框-->
    <el-dialog

      title="文章编辑"
      :visible.sync="dialogVisible"
      width="65%"
      >
      <el-form ref="info"  :model="ArticleForm" label-width="80px">
        <el-form-item label="标题" >
          <el-input v-model="ArticleForm.title" suffix-icon="el-icon-user">{{ArticleForm.title}}</el-input>
        </el-form-item>
        <el-form-item  label="作者">
          <el-input v-model="ArticleForm.author" suffix-icon="el-icon-s-comment" >{{ArticleForm.author}}</el-input>
        </el-form-item>
        <el-form-item label="所属栏目">
          <!--            选择器-->
          <el-select  v-model="ArticleForm.column_id" class="choose">
            <el-option
              v-for="item in columns"
              :key="item.cid"
              :label="item.column"
              :value="item.cid">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="正文">
          <!--        富文本编辑器-->
          <editor  ref="editor" ></editor>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">

    <el-button @click="dialogVisible = false">取 消</el-button>
    <el-button type="primary" @click="upArticle()">确 定</el-button>
  </span>
    </el-dialog>

  </div>
</template>

<script>
  import Welcome from './Welcome'
  import { getRequest, getRequestparams } from '../utils/app'
  import editor from './other/Editor'


  export default {
    components: { editor },
    data () {
      return {
        queryinfo: {
          // 查询条件
          querykey: '',
          //每页显示条数
          pagesize: 5,
          //当前第几页
          pagenumber: 1
        },
        articlelist: [],
        total: 0,
        id:'',
        dialogVisible: false,
        articleById:'',
        columns:[],
        ArticleForm:{
          title:"",
          author:"",
          column_id:"",
          body:"",
          column:'',
        }
      }
    },
    created () {
      this.getArticle();
      this.getcolumn();
    },
    mounted () {
       // this.close();
    },
    methods: {
      close(){
        this.dialogVisible=false;
      },
      init(body){
        this.$refs.editor.setHtml(body);
      },
      save(){

      },
      // 获取文章列表
      async getArticle () {
        const { data: res } = await this.$http.get('article/articleLists',{params:this.queryinfo})
        // const { data: res } = await getRequestparams('articleLists',{params:this.queryinfo})
        // console.log(res)
        console.log(res.list)
        console.log(res.total)
        this.total=res.total;
        for (const re of res.list) {
         const newtime = this.turndate(re.creationtime)
          re.creationtime=newtime;
        }
        this.articlelist = res.list
      },
      //获取条数 (废弃,使用分页助手获取条数
      //  async getCountArticle(){
      //    const { data: res } =  await this.$http.get('getCountArticle')
      //    this.total=res
      //    console.log(res)
      // },
      //转换日期格式
    turndate (date) {
        var nowdate = new Date(date).toLocaleDateString()
        return nowdate
      },
      //pagesize变化（每页显示多少条数据
  handleSizeChange(size){
        // console.log(size)
this.queryinfo.pagesize=size;
this.getArticle();
  },
      //当前页数
  handleCurrentChange(current){
        // console.log(current)
 this.queryinfo.pagenumber=current;
    this.getArticle();
  },
      //点击编辑 更新编辑文章
      updatearticle(id){
        console.log(id)
      },
      //点击删除按钮 删除对应的文章
    async  deletearticle(id){
        this.id=id;
        // const deletearticle = await this.$http.get("deletearticle",{ params:{ id:this.id } })
        const deletearticle = await getRequestparams("article/deletearticle",{  id:this.id  })
        if(deletearticle.status===200){
          this.$message.success("删除成功");
          this.getArticle();
          // return ;
        }else {
          this.$message.error("删除失败，服务器错误？？？")
        }
      },
      //弹框确认删除
      deletearticleopen(id) {
        this.$confirm('此操作将永久删除该文件, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.deletearticle(id);
          // this.$message({
          //   type: 'success',
          //    message: '删除成功!'
          // });
        }).catch(() => {
          this.$message({
            type: 'info',
            message: '已取消删除'
          });
        });
      },
      async updatearticle(id){
        this.dialogVisible=true
        try {
          const {data:res}=await this.$http.get("article/getArticleById",{ params:{id:id}})
          if(null!=res){
            this.ArticleForm=res;
            this.$refs.editor.setHtml(res.body);
            console.log(res.body)
          }
        }catch (e) {
        }

          // this.dialogVisible=true;
      },
     async upArticle(){
        try {
          this.ArticleForm.body=this.$refs.editor.getHtml();
         const {data:res}=await this.$http.post("article/upArticle" ,this.ArticleForm);
         if ("修改文章成功"===res.msg){
           this.$message.success(res.msg);
           this.dialogVisible=false;
           this.getArticle();
           return ;
         }else {
           this.$message.error(res.msg)
         }
        }catch (e) {
          this.$message.error("服务器错误")
        }

        // console.log(this.ArticleForm)
        // console.log(this.$refs.editor.getHtml())
        // alert(this.$refs.wangE.editorContent)
        // console.log(ari)
      },
      //获取所有栏目
      async getcolumn(){
        const {data:res}= await getRequest("submit/getcolumn")
        // console.log(res);
        this.columns=res;
        console.log(this.columns)
      },

    }
  }
</script>

<style scoped>
  .el-table {
    margin-top: 12px;
  }
  .el-pagination{
    margin-top: 15px;
  }
</style>
