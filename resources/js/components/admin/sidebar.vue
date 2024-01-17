<template>
  <div>
    <aside
      :class="[
        sidebar ? '_left_sidebar _hide_sidebar' : '_left_sidebar',
        mobSidebar ? '_mobSidebarOpen' : '',
      ]"
    >
      <div class="_left_sidebar_main">
        <div class="_left_sidebar_top">
          <div class="_left_sidebar_top_main">
            <div class="_left_sidebar_pic">
              <img
                v-if="authUser"
                class="_left_sidebar_img"
                src="https://i2.wp.com/airlinkflight.org/wp-content/uploads/2019/02/male-placeholder-image.jpeg?ssl=1"
                alt=""
                title=""
              />
            </div>
          </div>
          <p class="_left_sidebar_pro">
            {{ authUser.firstName }} {{ authUser.lastName }}
          </p>
          <p class="_left_sidebar_name">{{ authUser.email }}</p>
        </div>

        <div class="_left_sidebar_menu _1scrollbar">
          <Menu :theme="theme3" :active-name="activeRoute">
            <!-- <p class="_group_name"><Icon type="ios-more" /></p> -->
            <!-- <MenuItem to="/admin" name="index">
                            <Icon type="md-home" />
                            <span class="submenu_text">Dashboard</span>
                        </MenuItem> -->
            <MenuItem to="/admin/admin" name="admin">
              <i class="fas fa-user-cog"></i>
              <span class="submenu_text">Admins</span>
            </MenuItem>
            <MenuItem to="/admin/customer" name="customer">
              <i class="fas fa-user"></i>
              <span class="submenu_text">Customers</span>
            </MenuItem>
            <MenuItem to="/admin/product" name="product">
              <i class="far fa-list-alt"></i>
              <span class="submenu_text">Product</span>
            </MenuItem>
            <MenuItem
              v-if="authUser.userType == 'superAdmin'"
              to="/admin/transaction"
              name="transaction"
            >
              <i class="fas fa-clipboard-list"></i>
              <span class="submenu_text">Transaction</span>
            </MenuItem>
            <MenuItem to="/admin/driver" name="driver">
              <i class="fas fa-truck-pickup"></i>
              <span class="submenu_text">Driver</span>
            </MenuItem>
            <MenuItem to="/admin/category" name="category">
              <i class="far fa-list-alt"></i>
              <span class="submenu_text">Category</span>
            </MenuItem>
            <MenuItem to="/admin/vendor" name="vendor">
              <i class="fas fa-user-tie"></i>
              <span class="submenu_text">Vendor</span>
            </MenuItem>
            <MenuItem to="/admin/order" name="order">
              <i class="fas fa-clipboard-list"></i>
              <span class="submenu_text">Orders</span>
            </MenuItem>
          </Menu>
        </div>

        <div class="_left_sidebar_bottom _1border_color">
          <Menu :theme="theme3" active-name="1">
            <MenuItem name="logout">
              <a style="display: flex; color: #727e85" href="/logout">
                <Icon type="md-log-out" />
                <span class="submenu_text">Logout</span>
              </a>
            </MenuItem>
          </Menu>
          <!-- <p>Change theme</p>
                <RadioGroup v-model="theme3">
                    <Radio label="light"></Radio>
                    <Radio label="dark"></Radio>
                </RadioGroup> -->
        </div>
      </div>
    </aside>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
export default {
  data() {
    return {
      activeRoute: "index",
      sidebar: false,
      isHovering: false,
      theme3: "light",
      mobSearchOpen: false,
    };
  },
    computed: {
    ...mapGetters({
      mobSidebar: "getSidebar",
    }),
  },

  methods: {},
  watch: {
    // "$route.name": function (newVal, oldVal) {
    //    this.activeRoute = newVal;
    //   },
  },
  created() {},
};
</script>