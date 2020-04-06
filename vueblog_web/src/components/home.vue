<template>
  <el-container class="home_container">
    <!--    头部-->
    <el-header>
      <div>
        <img src="../assets/we.png" alt/>
      </div>
      <div>
        <span class="info">WE博客管理系统</span>
      </div>
      <div>
        <el-dropdown>
          <span class="el-dropdown-link" style="color:#303133 ">
            {{ user.username}}
            <i class="el-icon-arrow-down el-icon--right"></i>
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item>{{ user.realname }}</el-dropdown-item>
            <el-dropdown-item divided @click.native="logout"> 退出登陆</el-dropdown-item>
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
          text-color="#fff"
        >
          <!--           一级菜单-->
          <el-submenu :index="index+''" v-for="(item,index) in navlist" :key="index">
            <!--             <el-submenu :index="index+''" v-for="(item,index) in routes" v-if="!item.hidden" :key="index">-->
            <template slot="title">
              <!-- 图标 -->
              <!--                <i :class="iconsObj[item.id]"></i>-->
              <!-- 文本 -->
              <span>{{item.nav_name}}</span>
              <!--               <span>{{item.name}}</span>-->
            </template>
            <!--              二级菜单-->
            <!--           <el-menu-item-->
            <!--             @click="saveNav(second.path)"-->
            <!--              :index="second.path + ''"-->
            <!--              v-for="second in item.nav_secondList"-->
            <!--              :key="second.nav_id"-->
            <!--            >-->
            <el-menu-item :index="second.path" v-for="(second,indexj) in item.nav_secondList" :key="indexj">
              <template slot="title">
                <!-- 图标 -->
                <i class="el-icon-menu"></i>
                <!-- 文本 -->
                <span>{{second.nav_Second_name}}</span>
                <!--                <span>  {{child.name}}</span>-->
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
    data () {
      return {
        navlist: [],
        chenname: 'chendnegbao',
        activepath: '',
        user: JSON.parse(window.sessionStorage.getItem('user')),
        icons: []
      }
      second
    },
    computed: {
      routes () {
        return this.$store.state.routes
      }
    },
    created () {
      this.getroutes()
      this.gethomenav()
    },

    methods: {
      getroutes () {
        // console.log(this.user)
        // console.log(this.$store.state)
      },
     async logout () {

        const { data: res } = await getRequest('logout')
         // console.log(res)
       try{
       if(res.code===200){
         this.$message.success("退出成功，返回登陆页")
         this.$router.push("/login")
       }else {
         this.$message.error("退出失败，请重试")
       }

     }catch (e) {
         this.$message.error("退出失败，请重试")
      }
      },
      async gethomenav () {

        const { data: res } = await getRequest('home')


        this.navlist = res
      },
      // saveNav (path) {
      //   window.sessionStorage.setItem('path', path)
      //   this.activepath = path
      // },


    }
  }
</script>

<style lang="less" scoped>
  .el-header {
    background-color: #4980b5;
    display: flex;
    justify-content: space-between;
    padding-left: 0;
    align-items: center;
  }

  .el-aside {
    background-color: #262d33;
  }

  .el-main {
    background-color: #f2f6fc;
  }

  .home_container {
    height: 100%;
  }

  img {
    width: 50px;
    height: 50px;
    padding-left: 0;
  }

  .info {
    font-family: "WenQuanYi Micro Hei";
    color: white;
    font-size: 35px;
    line-height: 60px;
  }
</style>

