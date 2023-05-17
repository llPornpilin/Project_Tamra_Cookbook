import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'HomePage',
    meta: { login: true }, //+
    component: () => import('./views/HomePage.vue') // set home as path '/'
  },
  {
    path: '/allmenu',
    name: 'AllMenu',
    meta: { login: true }, //+
    component: () => import('./views/AllMenu.vue')
  },
  {
    path: '/allmenu/:category_type/:category_id',
    name: 'CategoryMenu',
    meta: { login: true }, //+
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
    meta: { login: true }, //+
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

//+
router.beforeEach((to, from, next) => {
  const isLoggedIn = !!localStorage.getItem('token')

  if (to.meta.login && !isLoggedIn) {
    alert('Please login first!')
    next({ path: '/user/signin' })
  }

  if (to.meta.guess && isLoggedIn) {
    alert("You've already logged in")
    next({ path: '/' })
  }

  next()
})

export default router