<template>
  <div>
    <div class="_login">
      <div class="_login_left">
        <div class="_login_overlay"></div>

        <div class="authentic_nav_logo">
          <a href="/" class="authentic_nav_logo_a">
            <!-- <img
              src="/static/img/logo-icon.png"
              alt=""
              title=""
              class="_navbar_logo_img"
            />
            <img
              src="/static/img/logo-text.png"
              alt=""
              title=""
              class="_navbar_logo_img_text"
            /> -->
            <h3>Logo Image</h3>
          </a>
        </div>

        <p class="_login_left_text">
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam tellus
          elit.
        </p>

        <!-- <Button type="primary">Learn More</Button> -->
      </div>

      <div class="_login_right">
        <div class="_login_main">
          <div class="_login_top _1border_color">
            <p class="_login_top_text">Create a new account</p>
          </div>

          <div class="_login_form">
            <div class="row">
              <div class="col-12 col-md-6 col-lg-6">
                <div class="_1input_group">
                  <p class="_1label">First Name</p>
                  <Input v-model="data.firstName" placeholder="First Name" />
                </div>
              </div>
              <div class="col-12 col-md-6 col-lg-6">
                <div class="_1input_group">
                  <p class="_1label">Last Name</p>
                  <Input v-model="data.lastName" placeholder="Last Name" />
                </div>
              </div>

              <div class="col-12 col-md-12 col-lg-12">
                <div class="_1input_group">
                  <p class="_1label">Upload Image</p>
                  <Upload
                    ref="uploads"
                    type="drag"
                    :headers="{
                      'x-csrf-token': token,
                      'X-Requested-With': 'XMLHttpRequest',
                    }"
                    :on-success="handleSuccess"
                    :on-error="handleError"
                    :format="['jpg', 'jpeg', 'png']"
                    :max-size="2048"
                    :on-format-error="handleFormatError"
                    :on-exceeded-size="handleMaxSize"
                    action="/upload"
                  >
                    <div style="padding: 10px 0">
                      <Icon
                        type="ios-cloud-upload"
                        size="52"
                        style="color: #3399ff"
                      ></Icon>
                      <p>Click or drag image here to upload</p>
                    </div>
                  </Upload>

                  <div class="demo-upload-list" v-if="data.image">
                    <template>
                      <img :src="`${data.image}`" />
                      <div class="demo-upload-list-cover">
                        <Icon
                          type="ios-trash-outline"
                          @click="deleteImage(1)"
                        ></Icon>
                      </div>
                    </template>
                  </div>
                </div>
              </div>

              <div class="col-12 col-md-12 col-lg-12">
                <div class="_1input_group">
                  <p class="_1label">Email</p>
                  <Input v-model="data.email" placeholder="Email" />
                </div>
              </div>
              <div class="col-12 col-md-6 col-lg-6">
                <div class="_1input_group">
                  <p class="_1label">Password</p>
                  <Input
                    v-model="data.password"
                    type="password"
                    placeholder="Password"
                  />
                </div>
              </div>
              <div class="col-12 col-md-6 col-lg-6">
                <div class="_1input_group">
                  <p class="_1label">Confirm Password</p>
                  <Input
                    v-model="data.confirmPassword"
                    type="password"
                    placeholder="Confirm Password"
                  />
                </div>
              </div>

              <div class="col-12 col-md-6 col-lg-6">
                <div class="_1input_group">
                  <p class="_1label">Addess</p>
                  <Input v-model="data.address" placeholder="Addess" />
                </div>
              </div>
              <div class="col-12 col-md-6 col-lg-6">
                <div class="_1input_group">
                  <p class="_1label">Phone</p>
                  <Input @on-enter="submit" v-model="data.phone" placeholder="Phone">
                    <span slot="prepend">+88</span>
                  </Input>
                </div>
              </div>

              <div class="col-12 col-md-12 col-lg-12">
                <button @click="submit" class="_1btn _btn_long">Sign up</button>
              </div>
            </div>
          </div>

          <div class="_login_bottom">
            <p class="_login_do">
              Do you have a Account?
              <a href="/login" class="_3link _mar_l5">Login</a>
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
      isLoading: false,
      data: {
        firstName: "",
        lastName: "",
        image: "",
        email: "",
        password: "",
        confirmPassword: "",
        address: "",
        phone: "",
        userType: "user",
      },
      token: ''
    };
  },

  methods: {
    async submit() {
      if (this.data.firstName == "") return this.e("First name is required!");
      if (this.data.lastName == "") return this.e("Last name is required!");
      if (this.data.image == "") return this.e("Image is required!");
      if (this.data.email == "") return this.e("Email is required!");
      if (this.data.password == "") return this.e("Password is required!");
      if (this.data.confirmPassword == "")
        return this.e("Confirm password is required!");
      if (this.data.password != this.data.confirmPassword) {
        this.i("The password confirmation does not match!");
        return;
      }
      if (this.data.address == "") return this.e("address is required!");
      if (this.data.phone == "") return this.e("Phone is required!");

      delete this.data.confirmPassword;

      this.isLoading = true;

      const res = await this.callApi("post", "/app/registration", this.data);

      if (res.status === 201) {
        this.s("Registration Successfull!");
        this.$refs.uploads.clearFiles();
        this.data.firstName = "";
        this.data.lastName = "";
        this.data.image = "";
        this.data.phone = "";
        this.data.email = "";
        this.data.password = "";
        this.data.confirmPassword = "";
        this.data.address = "";
        window.location = "/accountVerified";
      } else if (res.status == 422) {
        for (let i in res.data.errors) {
          this.e(res.data.errors[i][0]);
        }
      } else {
        this.swr();
      }

      this.isLoading = false;
    },

    handleSuccess(res, file) {
      res = `/uploads/${res}`;
      // if (this.isEditItem) {
      //     this.editData.image = res
      // }
      this.data.image = res;
    },

    handleError(res, file) {
      console.log("res", res);
      this.$Notice.warning({
        title: "The file format is incorrect",
        desc: `${
          file.errors.file.length
            ? file.errors.file[0]
            : "Something went wrong!"
        }`,
      });
    },

    handleFormatError(file) {
      this.$Notice.warning({
        title: "The file format is incorrect",
        desc:
          "File format of " +
          file.name +
          " is incorrect, please select jpg or png.",
      });
    },

    handleMaxSize(file) {
      this.$Notice.warning({
        title: "Exceeding file size limit",
        desc: "File  " + file.name + " is too large, no more than 2M.",
      });
    },

    async deleteImage(isAdd) {
      let image;
      if (isAdd == 1) {
        image = this.data.image;
        this.data.image = "";
        this.$refs.uploads.clearFiles();
      } else {
        // // for editing
        // this.isImage = true
        // image = this.editData.iconImage
        // this.editData.iconImage = ''
        // this.$refs.editDataUploads.clearFiles()
      }

      const res = await this.callApi("post", "delete_image", {
        imageName: image,
      });
      if (res.status != 200) {
        this.data.image = image;
        this.swr();
      }
    },
  },

  async created() {
    this.token = window.Laravel.csrfToken;
  },
};
</script>

<style scoped>
.demo-upload-list {
  display: inline-block;
  width: 60px;
  height: 60px;
  text-align: center;
  line-height: 60px;
  border: 1px solid transparent;
  border-radius: 4px;
  overflow: hidden;
  background: #fff;
  position: relative;
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.2);
  margin-right: 4px;
}
.demo-upload-list img {
  width: 100%;
  height: 100%;
}
.demo-upload-list-cover {
  display: none;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(0, 0, 0, 0.6);
}
.demo-upload-list:hover .demo-upload-list-cover {
  display: block;
}
.demo-upload-list-cover i {
  color: #fff;
  font-size: 20px;
  cursor: pointer;
  margin: 0 2px;
}
</style>