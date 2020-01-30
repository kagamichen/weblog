import Vue from 'vue'
import App from './App.vue'
import router from './router'
import './plugins/element.js'
import '../src/assets/css/all.css'
import axios from 'axios'


axios.defaults.baseURL='http://127.0.0.1:8090/'
Vue.prototype.$http=axios

Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
