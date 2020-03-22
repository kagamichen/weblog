import Vue from 'vue'
import App from './App.vue'
import router from './router'
import './plugins/element.js'
import '../src/assets/css/all.css'
import axios from 'axios'
import store from '../store'
import { initMenu } from './utils/menus'


Vue.prototype.$http = axios

Vue.config.productionTip = false

// router.beforeEach((to, from, next) => {
//   // console.log(to )
//   if (to.path == '/') {
//     next();
//   } else {
//     initMenu( router, store);
//     next();
//   }
// })

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
