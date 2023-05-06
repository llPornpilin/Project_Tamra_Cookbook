import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'HomePage',
    component: () => import('./views/HomePage.vue') // set home as path '/'
  },
  {
    path: '/allmenu',
    name: 'AllMenu',
    component: () => import('./views/AllMenu.vue') // set home as path '/'
  },
  {
    path: '/allmenu/:category_type/:category_id',
    name: 'CategoryMenu',
    component: () => import('./views/AllMenu.vue') // set home as path '/'
  },
  {
    path: '/addmenu',
    name: 'addmenu',
    component: () => import('./views/AddMenu.vue') // set home as path '/'
  },
  {
    path: '/mymenu', // *********เพิ่ม params user_id*********
    name: 'mymenu',
    component: () => import('./views/MyMENU.vue') // set home as path '/'
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router