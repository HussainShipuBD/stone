import Vue from 'vue'
import Router from 'vue-router'
Vue.use(Router)


// import addEvents from './components/pages/addEvents.vue'
import index from './components/pages/index.vue'
import lending from './components/pages/lending.vue'
import pagesubCategory from './components/pages/pagesubCategory.vue'
import pageProduct from './components/pages/pageProduct.vue'
import productDetails from './components/pages/productDetails.vue'
import checkout from './components/pages/checkout.vue'
import privecy from './components/pages/privecy.vue'
import aboutUs from './components/pages/aboutUs.vue'
import pageOrder from './components/pages/pageOrder.vue'





import home from './components/pages/home.vue'
// import login from './components/pages/login.vue'
import register from './components/register.vue'
import accountVerified from './components/accountVerified.vue'
import sendAgain from './components/sendAgain.vue'

import admin from './components/admin/admin.vue'
import customer from './components/admin/customer.vue'
import driver from './components/admin/driver.vue'
import category from './components/admin/category.vue'
import subCategory from './components/admin/subCategory.vue'
import vendor from './components/admin/vendor.vue'
import product from './components/admin/product.vue'
import driverTra from './components/admin/driverTra.vue'
import vendorTra from './components/admin/vendorTra.vue'
import order from './components/admin/order.vue'
import transaction from './components/admin/transaction.vue'

import store from './store.js'
const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'index',
      component: index
    },
    {
      path: '/lending',
      name: 'lending',
      component: lending
    },
    {
      path: '/pagesubCategory/:id',
      name: 'pagesubCategory',
      component: pagesubCategory
    },
    {
      path: '/pageProduct/:id',
      name: 'pageProduct',
      component: pageProduct
    },
    {
      path: '/productDetails/:id',
      name: 'productDetails',
      component: productDetails
    },
    {
      path: '/checkout',
      name: 'checkout',
      component: checkout
    },
    {
      path: '/privecy',
      name: 'privecy',
      component: privecy
    },
    {
      path: '/aboutUs',
      name: 'aboutUs',
      component: aboutUs
    },
    {
      path: '/pageOrder',
      name: 'pageOrder',
      component: pageOrder
    },
    // {
    //   path: '/login',
    //   name: 'login',
    //   component: login
    // },
    {
      path: '/register',
      name: 'register',
      component: register
    },
    {
      path: '/accountVerified',
      name: 'accountVerified',
      component: accountVerified
    },
    {
      path: '/sendAgain',
      name: 'sendAgain',
      component: sendAgain
    },








    // Admin
    {
      path: '/admin/',
      name: 'home',
      component: home
    },

    {
      path: '/admin/admin',
      name: 'admin',
      component: admin
    },
    {
      path: '/admin/customer',
      name: 'customer',
      component: customer
    },
    {
      path: '/admin/driver',
      name: 'driver',
      component: driver
    },
    {
      path: '/admin/category',
      name: 'category',
      component: category
    },
    {
      path: '/admin/subCategory/:id',
      name: 'subCategory',
      component: subCategory
    },
    {
      path: '/admin/vendor',
      name: 'vendor',
      component: vendor
    },
    {
      path: '/admin/product',
      name: 'product',
      component: product
    },
    {
      path: '/admin/driverTra/:id',
      name: 'driverTra',
      component: driverTra
    },
    {
      path: '/admin/vendorTra/:id',
      name: 'vendorTra',
      component: vendorTra
    },
    {
      path: '/admin/order',
      name: 'order',
      component: order
    },
    {
      path: '/admin/transaction',
      name: 'transaction',
      component: transaction
    },

  ]
});





router.beforeEach((to, from, next) => {
  console.log(window.authUser.userType)
  if (to.path !== '/sendAgain'
    && window.authUser
    && window.authUser.status == "inActive"
    && window.authUser.userType == 'user') {
    next({ path: '/sendAgain' })
  }
  else next()
})


export default router;