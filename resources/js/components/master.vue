<template>
    <div>
      <div id="main-wrapper">
        <headermenu  v-if="$route.path != '/login'"/>
        <router-view/>
        <Footer  v-if="$route.path != '/login'"/>
      </div>
    </div>
</template>

<script>
import headermenu from './pages/headermenu.vue'
import Footer from './pages/footer.vue'
export default {
   components:{
        headermenu,
        Footer
   },
    data(){
       return {
          sidebar: false
       }
    }, 
    async created(){
      this.$store.commit('setAuthUser', (window.authUser));

      const res = await this.callApi("get", `/app/get_add_cart`);
      if (res.status === 200) {
        this.addCard = res.data;
        this.$store.commit('setAddCard', (res.data));
      } else {
        this.swr();
      }
    }
}
</script>