<template>
  <el-container class="home_container">
<!--    头部-->
  <el-header>
    <div>
      <img src="../assets/we.png"  alt=""/>

    </div>
    <div>
      <span class="info">WE博客管理系统</span>
    </div>
    <div>
      <el-dropdown>
      <span class="el-dropdown-link">
    下拉菜单<i class="el-icon-arrow-down el-icon--right"></i>
  </span>
      <el-dropdown-menu slot="dropdown">
        <el-dropdown-item>{{  chenname }}</el-dropdown-item>
        <el-dropdown-item>狮子头</el-dropdown-item>
        <el-dropdown-item>螺蛳粉</el-dropdown-item>
        <el-dropdown-item disabled>双皮奶</el-dropdown-item>
        <el-dropdown-item divided>蚵仔煎</el-dropdown-item>
      </el-dropdown-menu>
      </el-dropdown>
    </div>
    </el-header>
    <el-container>
<!--    侧边栏-->
    <el-aside width="200px">


<!--<导航栏区域-->
          <el-menu
            default-active="2"
            class="el-menu-vertical-demo"
            background-color="#262D33"
            :router="true"
           :default-active="this.$route.path"

            text-color="#fff">
<!--           一级菜单-->
            <el-submenu :index="item.nav_id + ''" v-for="item in navlist" >
              <template slot="title">
                <!-- 图标 -->
<!--                <i :class="iconsObj[item.id]"></i>-->
                <!-- 文本 -->
                <span>{{item.nav_name}}</span>
              </template>
<!--              二级菜单-->
              <el-menu-item
                @click="saveNav(second.path)"
                :index="second.path + ''"
                v-for="second in item.nav_secondList" :key="second.nav_id" >

                <template slot="title">
                  <!-- 图标 -->
                  <i class="el-icon-menu"></i>
                  <!-- 文本 -->
                  <span>{{second.nav_Second_name}}</span>
                </template>
              </el-menu-item>

            </el-submenu>

          </el-menu>

    </el-aside>
<!--      主体区域-->
    <el-main>
<!--路由占位符-->
      <router-view/>
    </el-main>
  </el-container>
  </el-container>

</template>

<script>
  import { getRequest } from '../utils/app'

  export default {
data(){
  return {
    navlist: [],
    chenname: 'chendnegbao',
    activepath:'',
  icons:[

  ]
  }

},
    created () {
      this.gethomenav()
    },

    methods: {
      async gethomenav(){
        const {data:res} = await getRequest('home')
// console.log(res)
     // const homenav=new Array();
     //    for (let i = 0; i <res.length; i++) {
     //       // console.log(res[i].nav_name);
     //       homenav.push(res[i].nav_name);
     //    }
        this.navlist=res;


//         const menulist  = res
// console.log(menulist)

      },
      saveNav(path){
        window.sessionStorage.setItem("path",path);
        this.activepath=path;
      }

    }
  }

</script>

<style lang="less" scoped>
.el-header{
  background-color:#4980B5;
  display: flex;
  justify-content: space-between;
  padding-left: 0;
  align-items: center;
}
  .el-aside{
    background-color:#262D33 ;
  }
  .el-main{
    background-color: #F2F6FC;
  }
.home_container{
  height: 100%;
}
  img{
    width: 50px;
    height: 50px;
    padding-left: 0;
  }
  .info{
    font-family: "WenQuanYi Micro Hei";
    color:white;
    font-size: 35px;
    line-height: 60px;
  }
</style>

