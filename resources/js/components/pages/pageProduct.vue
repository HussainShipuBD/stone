<template>
    <div>
        <div class="_1main_content">
            <div class="_explore">
                <div class="container">
                    <h2 v-if="product.length" class="_1title _text_center _mar_b20">{{ product[0].subcategory.name }}</h2>
                    <!-- <h2 class="_1title _text_center _mar_b20">A sub cat name</h2> -->

                    <p v-if="product && !product.length" class="_text_center _no_data">No Product found!</p>

                    <div class="row">
                        <!-- Items -->
                        <div v-for="(item, index) in product" :key="index" class="col-12 col-md-3 col-lg-3">
                            <div class="_2card">
                                <div class="_2card_pic">
                                    <!-- <img src="/static/img/image 6.png" alt="" title="" class="_2card_img"> -->
                                    <Carousel
                                        style="height:100%" 
                                        loop
                                        dots="none"
                                    >
                                        <CarouselItem style="height:100%" v-for="(item, index) in item.images" :key="index">
                                            <img v-if="item.image" :src="item.image" alt="" title="" class="_2card_img">
                                        </CarouselItem>
                                    </Carousel>
                                    <p class="_2card_tag">Price : {{ item.price }}</p>
                                </div>
                                <div class="_2card_bottom">
                                    <p class="_2card_title"  @click="$router.push('/productDetails/'+item.id)">{{ item.name }}</p>
                                    <p class="_2card_des">{{ item.description }}</p>
                                </div>
                            </div>
                        </div>
                        <!-- Items -->
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
   components:{
        
   },
    data(){
       return {
           product: []
       }
    }, 

    methods : {
        async getSubCategory(){
            const res = await this.callApi('get', `/app/getPage_product/${this.$route.params.id}`)
            if (res.status === 200) {
                this.product = res.data
                // this.addModal = false
            }else{
                this.swr()
            }
        }
    },

    created(){
        this.getSubCategory()
    }
}
</script>