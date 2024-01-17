<template>
    <div>
       <!-- <span v-if="this.$route.path=='/coming-soon' || this.$route.path=='/test1'">
         <router-view/>
       </span> -->

      <div id="main-wrapper">
        <headermenu v-if="$route.path != '/login'" />
        <sidebar v-if="$route.path != '/login'" />

        <div :class="[(sidebar? '_main_layout _mini_main_layout':'_main_layout') , ($route.path  != '/login'? '':'_login_layout')]"> 
          <router-view/>
        </div>
      </div>
    </div>
</template>

<script>
import headermenu from '../components/admin/headermenu.vue';
import sidebar from '../components/admin/sidebar.vue';

export default {
    components:{
      headermenu,
      sidebar
   },
    data(){
       return {
          sidebar: false
       }
    }, 
    created(){
      this.$store.commit('setAuthUser', (window.authUser));
    }
}
</script>