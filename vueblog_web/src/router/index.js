import Vue from 'vue'
import Router from 'vue-router'
import Login from '../components/Login'
// 导入全局变量表
import '../assets/css/all.css'
import Jquery from 'jquery'
import home from '../components/home'
import Welcome from '../components/Welcome'
import articleLists from '../components/articleLists'
import publishedListOf from '../components/publishedListOf'
import column from '../components/column'
import comment from '../components/comment'
import userset from '../components/userset'
import userRegister from '../components/userRegister'
import noauthority from '../components/other/noauthority'
Vue.use(Router)

export default new Router({
  routes: [
    //重定向到登录页面 默认情况
    {path: '/',redirect: '/login'},
    {path: '/login',component: Login,hidden:true},
    {path: '/home',
      component: home,
      redirect: '/Welcome',
      hidden:true,
      children:[
        {path: '/Welcome',component: Welcome},
        {path: '/articleLists',component: articleLists},
        {path:'/publishedListOf',component: publishedListOf},
        {path:'/column',component: column},
        {path:'/comment',component: comment},
        {path:'/userset',component: userset},
        {path:'/userRegister',component: userRegister},
        {path:'/noauthority',component: noauthority},

        ]}
  ]
})


