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
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router