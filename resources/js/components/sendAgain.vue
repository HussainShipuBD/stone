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

        <Button type="primary">Learn More</Button>
      </div>

      <div class="_login_right">
        <div class="_login_main">
          <div class="_login_top _1border_color">
            <!-- <p class="_login_top_text">Verification code</p> -->
            <p class="_mar_t15">
              You account is inactive. We have sent an OTP to your mobile
              number. Please check your phone and submit OTP for activating your
              account.
            </p>
          </div>

          <div class="_login_form">
            <div class="_1input_group">
              <p class="_1label">Verification code</p>
              <Input @on-enter="submit" v-model="data.code" placeholder="Code">
              </Input>
            </div>
            <div class="_1input_button" style="display: flex">
              <button
                @click="submit"
                class="_2btn _btn_long m-2"
                :disable="loading"
                :loading="loading"
              >
                Send again
              </button>
              <a href="/logout">
                <Button
                  @click="submit"
                  size="large"
                  class="m-2"
                  :disable="loading"
                  :loading="loading"
                >
                  Logout
                </Button>
              </a>
            </div>
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
        code: "",
      },
      loading: false,
    };
  },

  methods: {
    async submit() {
      if (this.data.code == "") return this.e("Code is required");
      this.loading = true;
      const res = await this.callApi("post", "/app/activateAccount", this.data);
      if (res.status === 200) {
        // this.s(res.data.msg)
        this.s("Account activation succssful.");
        this.data.code = "";
        window.location = "/";
      } else {
        if (res.status === 401) {
          this.i(res.data.msg);
          // this.e(res.data.msg)
        } else if (res.status == 422) {
          this.i(res.data.msg);
        } else {
          this.swr();
        }
      }
      this.loading = false;
    },
  },

  async created() {
    const res = await this.callApi("post", "/app/send_code_again");
    if (res.status != 200) {
      this.swr();
    }
  },
};
</script>