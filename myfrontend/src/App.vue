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
@import url('https://fonts.googleapis.com/css2?family=Anuphan:wght@300&display=swap');
#app {
  /* font-family: Avenir, Helvetica, Arial, sans-serif; */
  font-family: 'Anuphan', sans-serif;
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

/* AllMenu.vue , LikeFavorite.vue , MyMENU.vue  ---> กด like menu */
#btnLike{
  color: var(--yellow);
  font-size: 20px;
}
#btnLike:hover{
  color: var(--darkgreen);
  font-size: 18px;
}

/* ------test-modal-bulma-------------[START]-------------- */
/* AllMenu.vue , LikeFavorite.vue , MyMENU.vue  ---> scroll-y comment*/
.comment {
    overflow-y: scroll;
    height: 400px;
}
.comment::-webkit-scrollbar {
    width: 20px;
}
/* Track */
.comment::-webkit-scrollbar-track {
    margin-top: 40px;
    margin-bottom: 40px;
    border-radius: 100px;
}
/* Handle */
.comment::-webkit-scrollbar-thumb {
    background: var(--cream);
    border-radius: 100px;
    border: 5px solid transparent;
    background-clip: content-box;
}
/* AllMenu.vue , LikeFavorite.vue , MyMENU.vue  --->  กด comment menu */
#btnComment {
    color: var(--yellow);
    font-size: 20px;
}
#btnComment:hover {
    color: var(--darkgreen);
    font-size: 18px;
}
#commentItem0{
  background-color: #edb34f30;
}
#commentItem1{
  background-color: #edb34f4e;

}
/* ------test-modal-bulma----------[END]-------- */

/* AllMenu.vue , LikeFavorite.vue , MyMENU.vue  ---> กด favorite menu*/
#favorite_star_0 , #favorite_star_1{
  color: var(--yellow);
  font-size: 20px;
}
#favorite_star_0:hover , #favorite_star_1:hover{
  color: var(--yellow);
  font-size: 22px;
}
/* BTN */
#btnMethod, #btnMaterial{
  width:100px; 
  background-color: var(--yellow);
}
#btnMethod:hover, #btnMaterial:hover{
  width:100px; 
  background-color: var(--lightgreen);
  border-radius: 10px;
}
#btnSubComment{
  background-color: var(--yellow-l);
}
#btnSubComment:hover{
  background-color: var(--yellow);

}
/* ICON : delete */
#deleteItem{
  color: var(--yellow)
}
#deleteItem:hover{
  color: var(--lightgreen)
}

tr{
  text-align: left;
}
</style>