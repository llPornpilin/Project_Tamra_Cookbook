// -------------เพิ่มการเรียกใช้ router---------------------- //
import Vue from 'vue'
import App from './App.vue'
import router from './router' //เพิ่ม
import 'bulma/css/bulma.css' //เพิ่ม
import '@fortawesome/fontawesome-free/css/all.css'
import Vuelidate from 'vuelidate'
// import 'Favorite.css' // เพิ่ม

Vue.config.productionTip = false
Vue.use(Vuelidate)

new Vue({
  router,  // add router here
  render: h => h(App),
}).$mount('#app')