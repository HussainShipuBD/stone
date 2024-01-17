<template>
    <div>
        <div class="_menu" v-if="$route.path != '/register' && $route.path != '/accountVerified' && $route.path != '/sendAgain'">
            <div class="_menu_main">
                <div class="_menu_left">
                    <div class="_menu_logo">
                        <router-link to="/">
                            <img src="/img/logo.png" alt="" title="" class="_menu_logo_img">
                            <!-- <h3 class="">PathorerJogot</h3> -->
                        </router-link>
                    </div>
                </div>
                <ul class="_menu_cat_list">
                    <li  v-for="(item, index) in menu" :key="index">
                        <a  :href="`/pagesubCategory/${item.id}`">{{ item.name }}</a>
                    </li>
                </ul>
                <!-- <div class="_menu_cat_drop">
                    <p class="_menu_cat_drop_text">Category <i class="fas fa-chevron-down"></i></p>

                    <div class="_menu_cat_drop_main">
                        <ul class="_menu_cat_drop_list">
                            <li v-for="(item, index) in menu" :key="index" class="_menu_cat_drop_list_li">
                                <p class="_menu_cat_drop_subText">{{ item.name }} <i class="fas fa-chevron-right"></i></p>
                                <ul class="_menu_cat_drop_subList">
                                    <li v-for="(item,index) in item.subcategory" :key="index" @click="clickMenu(item.id)">{{ item.name }}</li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div> -->
                <div class="_menu_right">
                    <div :class="$route.path == '/'?'_menu_login _active':'_menu_login'">
                        <router-link to="/" class="_menu_login_text">Home</router-link>
                    </div>
                    <div class="_menu_login" v-if="authUser.userType == 'admin' || authUser.userType == 'superAdmin'">
                        <a class="_menu_login_text " href="/admin/admin">Admin</a>
                    </div>
                    <div v-if="authUser.userType == 'user'" class="_menu_login">
                        <router-link class="_menu_login_text " to="/checkout">
                            <i class="fas fa-shopping-cart"></i>
                            <p v-if="getAddCard" class="_noti_num">1</p>
                        </router-link>
                    </div>
                    <div v-if="!authUser" class="_menu_login">
                        <a href="/login" class="_menu_login_text">Login</a>
                    </div>
                    <div v-if="!authUser" class="_menu_login">
                        <router-link to="/register" class="_menu_login_text">Registration</router-link>
                    </div>
                    <div v-if="this.authUser" class="_menu_pro">
                        <Dropdown trigger="click" placement="bottom-end">
                            <div class="ivu-dropdown-rel">
                                <a href="javascript:void(0)" class="_menu_pro_main">
                                    <img :src="authUser.image" alt="" title="" class="_menu_pro_img"> 
                                    <p class="_menu_pro_name">{{ authUser.firstName }} {{ authUser.lastName }}</p> <i class="ivu-icon ivu-icon-ios-arrow-down"></i>
                                </a> 
                            </div>
                            <DropdownMenu slot="list">
                                <DropdownItem v-if="authUser.userType == 'user'"><router-link to="/pageOrder">Order</router-link></DropdownItem>
                                <DropdownItem><a href="/logout">Log out</a></DropdownItem>
                            </DropdownMenu>
                        </Dropdown>
                    </div>
                </div>

                <div :class="isMobileMenu? '_mobile_button _mobile_menu_open' : '_mobile_button'">
                    <i @click="isMobileMenu = true" class="fas fa-th-list _open"></i>
                    <i @click="isMobileMenu = false" class="fas fa-times _close"></i>
                </div>
            </div>
        </div>

        <div :class="isMobileMenu ? '_mob_menu _mob_menu_open' : '_mob_menu' ">
            <div class="_mob_menu_sidebar">
                <p class="_mob_menu_sidebar_close"><i class="fas fa-times"></i></p>
                <ul class="_menu_list _mob_menu_sidebar_list">
                    <li class="_menu_list_item">
                        <router-link to="/" class="_menu_login_text">Home</router-link>
                    </li>
                    <li class="_menu_list_item" v-if="authUser.userType == 'admin' || authUser.userType == 'superAdmin'">
                        <a class="_menu_login_text " href="/admin/admin">Admin</a>
                    </li>
                    <li v-if="authUser.userType == 'user'" class="_menu_list_item">
                        <router-link class="_menu_login_text " to="/checkout">
                            <i class="fas fa-shopping-cart"></i>
                            <p v-if="getAddCard" class="_noti_num">1</p>
                        </router-link>
                    </li>
                    <li class="_menu_list_item" v-if="!authUser">
                        <a href="/login" class="_menu_login_text">Login</a>
                    </li>
                    <li class="_menu_list_item" v-if="!authUser">
                        <router-link to="/register" class="_menu_login_text">Registration</router-link>
                    </li>
                    <li v-if="this.authUser" class="_menu_pro _menu_list_item">
                        <Dropdown trigger="click" placement="bottom-end">
                            <div class="ivu-dropdown-rel">
                                <a href="javascript:void(0)" class="_menu_pro_main">
                                    <img :src="authUser.image" alt="" title="" class="_menu_pro_img"> 
                                    <p class="_menu_pro_name">{{ authUser.firstName }} {{ authUser.lastName }}</p> <i class="ivu-icon ivu-icon-ios-arrow-down"></i>
                                </a> 
                            </div>
                            <DropdownMenu slot="list">
                                <DropdownItem v-if="authUser.userType == 'user'"><router-link to="/pageOrder">Order</router-link></DropdownItem>
                                <DropdownItem><a href="/logout">Log out</a></DropdownItem>
                            </DropdownMenu>
                        </Dropdown>
                    </li>
                </ul>
            </div>
      </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex";

export default {
  data() {
    return {
      sidebar: false,
      mobSearchOpen: false,
      mobSidebar: false,
      menu: [],
      subcategory:[],
      catIndex:0,
	  SubCatIndex:0,
      isMobileMenu: false
    }
  },

  methods: {
    changeDataHover(index) {
      // if(this.categories[index].category.length <= 0) {
      //     //this.textDetails = false
      //     return
      // }
      this.menuIndex = index;
      this.textDetails = true;
    },

    clickMenu(id) {
      // $router.push('/pageProduct/'+id)
      window.location = "/pageProduct/" + id;
    },
  },

  async created() {
    const res = await this.callApi("get", "/app/menus");
    if (res.status === 200) {
      this.menu = res.data;
    } else {
      this.swr();
    }
  },

  computed: {
    ...mapGetters(["getAddCard"]),
  },
};
</script>