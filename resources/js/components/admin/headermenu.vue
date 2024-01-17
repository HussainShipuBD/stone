<template>
  <div>
    <nav
      :class="
        sidebar
          ? '_navbar _fixed_top _navbar_light _navbar_wap _mini_navbar'
          : '_navbar _fixed_top _navbar_light _navbar_wap'
      "
    >
      <div class="_navbar_left">
        <div class="_navbar_logo">
          <router-link
            to="/admin/admin"
            class="_navbar_logo_link">
            <img src="/img/logo.png" alt="" />
          </router-link>
        </div>
      </div>
      <div :class="isMobileButton ? '_mobile_button _mobile_menu_open' : '_mobile_button'">
          <i @click="showSidebar(true)" class="fas fa-th-list _open"></i>
          <i @click="showSidebar(false)" class="fas fa-times _close"></i>
      </div>

      <div class="_navbar_right">
        <ul class="_navbar_right_list">
          <li class="_navbar_right_list_li" @click="$router.push('/')">
            <a href="/">home</a>
            <!-- <router-link to="/">Home</router-link> -->
          </li>

          <li class="_nav_pro">
            <div class="_nav_pros_main" href="javascript:void(0)">
              <p class="_nav_pro_text">
                {{ authUser.firstName }} {{ authUser.lastName }}
              </p>
              <div class="_nav_pro_pic">
                <img
                  class="_nav_pro_img"
                  src="https://i2.wp.com/airlinkflight.org/wp-content/uploads/2019/02/male-placeholder-image.jpeg?ssl=1"
                  alt=""
                  title=""
                />
              </div>

              <Dropdown trigger="click" placement="bottom-end">
                <a class="_nav_pros_main" href="javascript:void(0)">
                  <Icon type="ios-arrow-down"></Icon>
                </a>
                <DropdownMenu slot="list">
                  <DropdownItem><a href="/logout">Logout</a></DropdownItem>
                </DropdownMenu>
              </Dropdown>
            </div>
          </li>
        </ul>
      </div>
    </nav>
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
      isSidebar: false,
      isMobileButton: false
    };
  },

  computed: {
    ...mapGetters({
      sidebar: "getSidebar",
    }),
  },

  methods: {
    showSidebar(value) {
      this.isMobileButton = !this.isMobileButton
      this.$store.commit("setSidebar", value);
    },
  },

  created() {
    // console.log(this.authUser, 'yes')
  },
};
</script>