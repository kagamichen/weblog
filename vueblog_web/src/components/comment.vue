<template>
   <div>

       <!--      面包屑-->
       <el-breadcrumb separator="/">
         <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
         <el-breadcrumb-item>栏目管理</el-breadcrumb-item>
         <el-breadcrumb-item>评论列表</el-breadcrumb-item>
       </el-breadcrumb>
<!--     !&#45;&#45;  卡片区域&ndash;&gt;-->
     <el-card class="box-card body-card">
<!--选择栏目，文章显示对应的评论-->

       <el-row :gutter="30">
         <el-col :span="4">
           <div>
             <el-select  v-model="columntemp" placeholder="选择栏目" @change="getarticleselect($event)">
               <el-option
                 v-for="item in column"
                 :key="item.cid"
                 :label="item.column"
                 :value="item.cid"
                 >
               </el-option>
             </el-select>
           </div>
         </el-col>
         <el-col :span="4">
           <div>
             <el-select  v-model="titletemp" placeholder="选择文章" @change="getcomment($event)">
               <el-option
                 v-for="item in title"
                 :key="item.id"
                 :label="item.title"
                 :value="item.id">
               </el-option>
             </el-select>
           </div>
         </el-col>


         <el-col :span="6">
           <el-alert
             title="选择相应的栏目及文章的评论"
             type="info">
           </el-alert>
         </el-col>


       </el-row>




       <el-table
         :data="commenttable"
         style="width: 90%"
         max-height="250">
         <el-table-column
           fixed
           prop="commenttime"
           label="日期"
           width="150">
         </el-table-column>
         <el-table-column
           prop="user"
           label="姓名"
           width="120">
         </el-table-column>

         <el-table-column
           prop="content"
           label="评论内容"
           width="120">
         </el-table-column>
         <el-table-column
           prop="title"
           label="评论文章"
           width="300">
         </el-table-column>
         <el-table-column
           prop="pid"
           label="评论序号"
           width="120">
         </el-table-column>
         <el-table-column
           fixed="right"
           label="操作"
           width="120">
           <template slot-scope="scope">
             <el-button
               @click.native.prevent="deleteRow(scope.row.pid)"
               type="text"
               size="small">
              移除
             </el-button>
           </template>
         </el-table-column>
       </el-table>
<el-row :gutter="30" class="inputComment">
  <el-col :span="4">
    <el-input v-model="CommentUser"  placeholder="输入评论用户名" />
  </el-col>

  <el-col :span="7">

    <el-input v-model="AddComment"  placeholder="添加评论">
      <el-button  @click="addComment()" icon="el-icon-circle-plus-outline" slot="append"/>
    </el-input>

  </el-col>
</el-row>

     </el-card>

   </div>
</template>

<script>
  import { get, getRequest, getRequest2, getRequestparams } from '../utils/app'


  export default {

    data () {
      return {
      commenttable:[],
      column:[],
        title:[],
        query: {
          article:''
        },
        columntemp:'',
        titletemp:'',
        AddComment:'',
        CommentUser:''
      }

    },
    created () {
      this.getcomment();
      this.getcolumn();

    },
    methods:{
      //获得评论
     async getcomment(temps){
       console.log(temps)
      const {data:res}= await getRequestparams("comment/getcomment",{aid:temps})
       if("403"===res.code){
         this.$message.error(res.msg)
         await this.$router.push("/noauthority")
         return ;
       }
       console.log(res)
       for (const re of res) {
        const time=this.turndate(re.commenttime)
         re.commenttime=time
       }
        this.commenttable=res;
      },
      async getcolumn(){
       const {data:res}=await getRequest("submit/getcolumn")
        // console.log(res)
        this.column=res;
      },
      //通过栏目id获取文章列表
   async getarticleselect(temp){
       console.log(temp)
    // const {data:res}= await get("getarticleselect",{params:{column_id:temp}})
    const {data:res}= await getRequestparams("comment/getarticleselect",{column_id:temp})
     console.log(res)
     this.title=res

      },
    async addComment(){
       console.log(this.AddComment)
       console.log(this.titletemp)
      try {
      const {data:res} = await this.$http.get('comment/AddComment',{ params:{ comment:this.AddComment,aid:this.titletemp,CommentUser:this.CommentUser} })
      if("添加成功"==res.msg){
        this.$message.success(res.msg)
        this.getcomment()
      }else {
        this.$message.error(res.msg)
      }
      }catch (e) {
        this.$message.error("服务器错误")
      }
    },
 async deleteRow(pid){
       console.log(pid)

       try {
         const {data:res}=await this.$http("comment/deleteComment",{params:{commentId:pid}})
               if("删除成功"==res.msg){
                 this.$message.success(res.msg)
                 this.getcomment()
               }else {
                 this.$message.error(res.msg)
               }
           }catch (e) {
         this.$message.error("服务器错误")
       }

  },
      turndate (date) {
        var nowdate = new Date(date).toLocaleDateString()
        return nowdate
      },
    }
  }
</script>

<style scoped>
.inputComment{

  margin-top: 20px;
}


</style>
