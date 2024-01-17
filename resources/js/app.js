require('./bootstrap');
window.Vue = require('vue')
import router from './router'
import store from './store'
import ViewUI from 'view-design';


Vue.use(ViewUI);
import common from './common'
Vue.mixin(common)


import iView from 'iview';
// import 'iview/dist/styles/iview.css';
import locale from 'iview/dist/locale/en-US';
Vue.use(iView, { locale });
import Vue from 'vue';

// import store from './store'
import Vuex from 'vuex';
Vue.use(Vuex);

Vue.component('mainapp', require('./components/mainapp.vue').default)
Vue.component('master', require('./components/master.vue').default)
Vue.component('login', require('./components/login.vue').default)

const app = new Vue({
    el: '#app',
    router,
    store
})