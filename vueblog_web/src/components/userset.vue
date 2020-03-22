<template>
  <div>
  <!--      面包屑-->
  <el-breadcrumb separator="/">
    <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
    <el-breadcrumb-item>用户管理</el-breadcrumb-item>
    <el-breadcrumb-item>用户设置</el-breadcrumb-item>
  </el-breadcrumb>
<!--    卡片区域-->
   <el-card class="box-card body-card">
     <el-row :gutter="20">
       <el-col :span="10">
         <div>
           <el-input  class="input-with-select" placeholder="请输入标题来搜索文章">
             <el-button  icon="el-icon-search" slot="append"/>
           </el-input>
         </div>
       </el-col>
     </el-row>
<!--用户卡片-->
     <div class="user-container">
     <el-card class="box-card user-card" v-for="(item,index) in UserSet" :key="index">
       <div slot="header" class="clearfix">
         <span style="color: #67C23A">{{item.namezh}}</span>
         <el-button style="float: right; padding: 3px 0 ;color: #F56C6C" type="text" icon="el-icon-delete" @click="deleteUsereopen(item.id)"/>
       </div>
        <div >
          <span class="info">姓名：{{item.realname}}</span>
          <span class="info">账号：{{item.username}}</span>
          <span class="info">电话：{{item.phone}}</span>
        </div>



     </el-card>
     </div>
   </el-card>
</div>

</template>

<script>
  export default {
    data(){
      return{
        UserSet: []
      }

    },
    created () {
    this.getAllUserSet()
    },
    methods: {
     async getAllUserSet(){
       try {
       const {data:res}=await this.$http.get("/userset/getAllUserSet")
         if("403"===res.code){
           this.$message.error(res.msg)
           await this.$router.push("/noauthority")
           return ;
         }
           this.UserSet=res;

        }catch (e) {
          console.log(2)
        }
      },
     async deleteUser(id){
       if (id==1) {
         this.$message.error("权限不足不能删除管理员")
         return ;
       }
       try {
         const {data:res}=await this.$http.get("/userset/deleteUser",{params:{id:id}})
         console.log(res)
         if ("删除成功"==res.msg){
           this.$message.success("删除成功")
           this.getAllUserSet()
         }else {
           this.$message.error("删除错误")
         }

       }catch (e) {
         this.$message.error("删除错误")
       }
      },
      //弹框确认删除
      deleteUsereopen(id) {
        this.$confirm('此操作将永久删除该用户, 是否继续?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
         this.deleteUser(id);
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
      }
    }
  }
</script>

<style scoped>
.user-card{
  width: 28%;
  margin-top: 20px;
}
  .user-container{
    margin-top: 10px;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
  }
  .info{
    display:block;
    margin-bottom: 8px;
    font-family: "PingFang SC";
    color: #909399;
  }
</style>
