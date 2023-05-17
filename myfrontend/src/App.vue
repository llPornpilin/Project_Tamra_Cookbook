<!-- ลบ code เก่าออก และใส่ code ใหม่เข้าไป  โดย tag <router-view/> จะเปลี่ยนไปตาม router ที่ตั้งไว้  -->
<template>
  <div id="app">
    <router-view :key="$route.fullPath" @auth-change="onAuthChange" :user="user" />
  </div>
</template>

<script>
// import HelloWorld from './components/HelloWorld.vue'
import axios from '@/plugins/axios' //+  axios interceptor

export default {
  name: 'App',
  data() {
    return {
      user: null
    }
  },
  mounted() {
    this.onAuthChange()
  },
  methods: {
    onAuthChange() {
      const token = localStorage.getItem('token')
      if (token) {
        this.getUser()
      }
    },
    getUser() {
      // const token = localStorage.getItem('token')
      axios.get('/user/me').then(res => {
        this.user = res.data
        console.log("res.data in App.vue --> ",res.data);
      })
    },
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  /* margin-top: 60px; */
}

body {
    --yellow: #F0BB62;
    --yellow-l: #f0bc62ca;
    --cream: #f4eea9;
    --cream-l: #f1ebae9a;
    --darkgreen: #064635;
    --lightgreen: #519259;
    --black: #000;
    --white: #fff;
    --height1: 920px;
    --font1: 'Lobster Two', cursive;
    --font2: 'Montserrat Alternates', sans-serif;
    background-color: var(--cream);
    min-height: 100vh;
    margin: 0;
    padding: 0;
    font-family: var(--font2);
}
</style>