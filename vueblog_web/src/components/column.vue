<template>
  <div>
  <!--      面包屑-->
  <el-breadcrumb separator="/">
    <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
    <el-breadcrumb-item>栏目管理</el-breadcrumb-item>
    <el-breadcrumb-item>栏目详细</el-breadcrumb-item>
  </el-breadcrumb>

<!--  卡片区域-->
  <el-card class="box-card">
    <!--        添加栏目栏-->
    <el-row :gutter="20">
      <el-col :span="6">
        <div>
        <el-input v-model="inputcolumn" placeholder="请输入栏目名字"/>
        </div>
      </el-col>
      <el-col :span="6">
        <div>
     <el-button type="primary" @click="addcolumn()" >增加栏目</el-button>
        </div>
      </el-col>
    </el-row>


    <el-table
      :data="columntable"
      style="width: 100%">
      <el-table-column
        label="日期"
        width="180">
        <template slot-scope="scope">
          <i class="el-icon-time"></i>
          <span style="margin-left: 10px">{{ scope.row.updatetime }}</span>
        </template>
      </el-table-column>
      <el-table-column
        label="栏目名"
        width="180">
        <template slot-scope="scope">
          <el-popover trigger="hover" placement="top">
            <p>姓名: {{ scope.row.name }}</p>
            <p>住址: {{ scope.row.address }}</p>
            <div slot="reference" class="name-wrapper">
              <el-tag size="medium">{{ scope.row.column }}</el-tag>
            </div>
          </el-popover>
        </template>
      </el-table-column>
      <el-table-column
        label="栏目ID"
        width="180">
        <template slot-scope="scope">

          <span style="margin-left: 10px">{{ scope.row.cid }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button
            size="mini"
            @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
          <el-button
            size="mini"
            type="danger"
            @click="handleDelete( scope.row.cid)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

  </el-card>
  </div>
</template>

<script>
  import { getRequest } from '../utils/app'

  export default {
    data(){
      return{
        columntable:[],
        inputcolumn:'',
        cid:''

      }
    },
    created () {
      this.getcolumn();
    },
    methods:{
      //获取栏目所有信息
     async getcolumn (){

       const {data:res}= await getRequest("getcolumn")
        // console.log(res)

       for (const re of res) {
         re.updatetime=this.turndate(re.updatetime)
       }
       this.columntable=res
      },
      //添加栏目
      async addcolumn(){
        const {data:res}=await getRequest("addcolumn",{ params:{ column:this.inputcolumn } })

        console.log(res)
        if (res==="添加成功"){
          this.$message.success("添加成功")
          this.getcolumn()
        }else{
          this.$message.error("添加失败，请稍后再试")
        }
     },
      turndate (date) {
        var nowdate = new Date(date).toLocaleDateString()
        return nowdate
      },
    async  handleDeletetest(cid){
       console.log(cid)
        this.cid=cid
    const {data:res} =await getRequest("deletecolumn",{ params:{cid:this.cid}})
      if(res==="删除成功"){
        this.$message.success("删除成功")
        this.getcolumn();
      }else {
        this.$message.error("删除失败，请稍后再试")
      }
      },
  //弹框确认删除
      handleDelete(cid) {
    this.$confirm('此操作将永久删除该栏目, 是否继续?', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    }).then(() => {
     this.handleDeletetest(cid);
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

</style>
