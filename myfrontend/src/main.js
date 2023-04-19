// -------------เพิ่มการเรียกใช้ router---------------------- //
import Vue from 'vue'
import App from './App.vue'
import router from './router' //เพิ่ม
import 'bulma/css/bulma.css' //เพิ่ม
// import 'Favorite.css' // เพิ่ม

Vue.config.productionTip = false

new Vue({
  router,  // add router here
  render: h => h(App),
}).$mount('#app')