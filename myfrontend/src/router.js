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
    component: () => import('./views/AllMenu.vue')
  },
  {
    path: '/allmenu/:category_type/:category_id',
    name: 'CategoryMenu',
    component: () => import('./views/AllMenu.vue')
  },
  {
    path: '/addmenu',
    name: 'addmenu',
    component: () => import('./views/AddMenu.vue')
  },
  {
    path: '/mymenu',
    name: 'mymenu',
    component: () => import('./views/MyMENU.vue')
  },
  // {
  //   path: '/user/me',
  //   name: 'signup',
  //   component: () => import('./views/SignUp.vue') 
  // },
  {
    path: '/user/signup',
    name: 'signup',
    component: () => import('./views/SignUp.vue')
  },
  {
    path: '/user/signin',
    name: 'signin',
    component: () => import('./views/SignIn.vue')
  },
  {
    path: '/search_menu',
    name: 'search',
    component: () => import('./views/AllMenu.vue')
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router