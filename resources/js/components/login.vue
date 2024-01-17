<template>
  <div>
    <div class="_login">
      <div class="_login_left">
        <div class="_login_overlay"></div>

        <div class="authentic_nav_logo">
          <a href="/" class="authentic_nav_logo_a">
            <!-- <img src="/static/img/logo-icon.png" alt="" title="" class="_navbar_logo_img"> 
                        <img src="/static/img/logo-text.png" alt="" title="" class="_navbar_logo_img_text"> -->
            <h3>Logo Image</h3>
          </a>
        </div>

        <p class="_login_left_text">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam tellus
          elit.
        </p>
      </div>

      <div class="_login_right">
        <div class="_login_main">
          <div class="_login_top _1border_color">
            <p class="_login_top_text">Login your account</p>
          </div>

          <div class="_login_form">
            <div class="_1input_group">
              <p class="_1label">Email</p>
              <Input @on-enter="login" v-model="data.email" placeholder="Enter your email" />
            </div>
            <div class="_1input_group">
              <p class="_1label">Password</p>
              <Input
                type="password"
                v-model="data.password"
                @on-enter="login"
                placeholder="Enter your password"
              />
            </div>
            <div class="_1input_button">
              <!-- <Button
                class="_2btn _btn_long"
                @click="login"
                @keyup.enter.native="login"
                :disable="loading"
                :loading="loading"
                type="primary"
                >Log in</Button
              > -->
              <button
                class="_2btn _btn_long"
                @click="login"
                :disable="loading"
                :loading="loading"
                type="primary"
                >Log in</button
              >
            </div>
          </div>

          <div class="_login_bottom">
            <p class="_login_do">
              Don't have Account?
              <a class="_3link _mar_l5" href="/register"
                >Register Now</a
              >
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      data: {
        email: "",
        password: "",
      },
      loading: false,
    };
  },

  methods: {
    async login() {
      if (this.data.email.trim() == "") return this.e("Email is required");
      if (this.data.password.trim() == "")
        return this.e("Password is required");
      if (this.data.password.length < 6)
        return this.e("Incorrect login details");
      this.loading = true;
      const res = await this.callApi("post", "/app/login", this.data);
      if (res.status === 200) {
        this.$store.commit('setAuthUser', (res.data));
        this.s("Logged in successfully!");
        if (this.authUser.userType == "admin" || this.authUser.userType == "superAdmin") {
          window.location = "/admin/admin";
        } else {
          window.location = "/lending";
        }
      } else {
        if (res.status === 401) {
          this.e(res.data.msg);
          window.location = "/sendAgain";
        } else if (res.status == 422) {
          // for(let i in res.data.errors){
          // 	this.e(res.data.errors[i][0])
          // }
          this.e("Incorrect login details!");
        } else {
          this.swr();
        }
      }
      this.loading = false;
    },
  },
  created() {
  },
};
</script>