<template>
  <div>
    <div class="_1main_content">
      <div class="_1banner">
        <div class="_1banner_main">
          <div class="container">
            <div class="row align-items-center">
              <div class="col-12 col-md-6 col-lg-6">
                <h2 class="_1banner_title">
                  আমাদের প্রতিষ্ঠানের নাম পাথরের জগৎ। আমাদের প্রতিষ্ঠান শুধু
                  মাত্র পাথর নিয়েই কাজ করে থাকে। আপনি আপনার স্বপ্নের বাড়ি তৈরী
                  নিয়ে ভাবছেন??
                </h2>
                <p class="_1banner_text">
                  আমাদের প্রতিষ্ঠান আপনাকে দিবে সেই গুনগত মানের প্রাকৃতিক পাথর।
                  যা ইঞ্জিনিয়ারদের দ্বারা পরিক্ষিপ্ত। সাথে রয়েছে ট্রান্সপোর্টের
                  ব্যবস্থা।
                </p>
                <!-- <div class="_1banner_search">
                                    <div class="_1banner_search_input"><input type="text" placeholder="Search Course you want to learn..." /></div>
                                    <div class="_1banner_search_button">
                                        <button class="_1btn _pre_icon _btn_large"><i class="fas fa-search"></i> Search</button>
                                    </div>
                                </div> -->
              </div>
              <div class="col-12 col-md-6 col-lg-6">
                <div class="_1banner_main_pic">
                  <div class="_1banner_main_pic_main">
                    <img
                      src="/img/banner.gif"
                      alt=""
                      title=""
                      class="_1banner_main_img"
                    />
                  </div>
                  <!-- <div class="_1banner_main_pic_one"><img src="/static/img/book_man.png" alt="" title="" class="_1banner_main_pic_one_img" /></div>
                                    <div class="_1banner_main_pic_two"><img src="/static/img/man_black.png" alt="" title="" class="_1banner_main_pic_two_img" /></div>
                                    <div class="_1banner_main_pic_three"><img src="/static/img/_tir.png" alt="" title="" class="_1banner_main_pic_three_img" /></div> -->
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="_1banner_layer_one"></div>
        <div class="_1banner_layer_two"></div>
      </div>

      <!-- Section one -->
      <div class="_explore">
        <div class="container">
          <h2 class="_1title _text_center _mar_b20">All Category</h2>
          <div class="row">
            <div
              v-for="(item, index) in category"
              :key="index"
              class="col-12 col-md-3 col-lg-3 _mar_b30"
            >
              <div
                @click="$router.push('/pagesubCategory/' + item.id)"
                class="_1card"
              >
                <p class="_1card_title">{{ item.name }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- Section one -->

      <!-- Section Two -->
      <div class="_fearured" v-for="(item, index) in subCategory" :key="index">
        <div class="container">
          <div class="_page_title">
            <h2 class="_1title _page_title_text">{{ item.name }}</h2>
            <!-- <a href="" class="_page_title_more">View all</a> -->
          </div>

          <div v-if="item.product && !item.product.length" class="_text_center">
            <p class="_noFound">No Product Found!</p>
          </div>
          <div v-else class="row">
            <div
              v-for="(item, index) in item.product"
              :key="index"
              class="col-12 col-md-3 col-lg-3"
            >
              <div class="_2card">
                <div class="_2card_pic">
                  <!-- <img src="/static/img/image 6.png" alt="" title="" class="_2card_img"> -->
                  <Carousel style="height: 100%" loop dots="none">
                    <CarouselItem
                      style="height: 100%"
                      v-for="(item, index) in item.images"
                      :key="index"
                    >
                      <img
                        v-if="item.image"
                        :src="item.image"
                        alt=""
                        title=""
                        class="_2card_img"
                      />
                    </CarouselItem>
                  </Carousel>
                  <p class="_2card_tag">Price : {{ item.price }}</p>
                </div>
                <div class="_2card_bottom">
                  <p
                    class="_2card_title"
                    @click="$router.push('/productDetails/' + item.id)"
                  >
                    {{ item.name }}
                  </p>
                  <p class="_2card_des">{{ item.description }}</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- Section Two -->
    </div>
  </div>
</template>

<script>
export default {
  components: {},
  data() {
    return {
      category: [],
      subCategory: [],
    };
  },

  methods: {
    async getCategory() {
      const res = await this.callApi("get", "/app/get_category");
      if (res.status === 200) {
        this.category = res.data;
      } else {
        this.swr();
      }
    },

    async getSubcatProduct() {
      const res = await this.callApi("get", "/app/get_subBategory_product");
      if (res.status === 200) {
        this.subCategory = res.data;
      } else {
        this.swr();
      }
    },
  },

  created() {
    this.getCategory();
    this.getSubcatProduct();
  },
};
</script>