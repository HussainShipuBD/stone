<template>
    <div>
        <div class="_1main_content">
            <!-- Slider zoom -->
            <div class="_singlePro_main">
                <div class="container">
                    <!-- <div class="_singlePro_header">
                        <router-link class="_singlePro_header_link" to="/"><i class="fas fa-arrow-left"></i></router-link>

                        <p class="_singlePro_header_react _active"><i class="fas fa-heart"></i></p>
                    </div> -->

                    <div class="row">
                        <div class="col-12 col-md-6 col-lg-6">
                            <div class="_singlePro_left">
                                <Carousel
                                    :autoplay="setting.autoplay"
                                    :autoplay-speed="setting.autoplaySpeed"
                                    :dots="setting.dots"
                                    :radius-dot="setting.radiusDot"
                                    :trigger="setting.trigger"
                                    :arrow="setting.arrow"
                                >
                                    <CarouselItem v-if="product.images" v-for="(item, index) in product.images" :key="index">
                                        <div class="_singlePro_left_pic">
                                            <img class="_singlePro_left_img" :src="item.image" alt="" title="">
                                        </div>
                                    </CarouselItem>
                                </Carousel>
                                <!-- <div class="_singlePro_left_pic">
                                    <img class="_singlePro_left_img" src="/static/img/Rectangle 1031 (6).png" alt="" title="">
                                </div> -->
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-lg-6">
                            <div class="_singlePro_right">
                                <h2 class="_singlePro_title">{{ product.name }}</h2>

                                <h1 class="_singlePro_price">Tk - {{ product.price }} <span> / feet</span></h1>

                                <p class="_singlePro_text">{{ product.description }}</p>

                                <div v-if="authUser.userType == 'user'" class="_singlePro_que_main">
                                    <p class="_singlePro_label">Quantity</p>

                                    <div class="_singlePro_quei">
                                        <!-- <p class="_singlePro_quei_icon"><Icon type="md-remove" /></p> -->
                                        <div class="_singlePro_quei_main">
                                            <InputNumber style="width:100%" size="large" :min="1" v-model="data.quantity" placeholder="--"></InputNumber>
                                        </div>
                                        <!-- <p class="_singlePro_quei_icon"><Icon type="md-add" /></p> -->
                                        <p class="_singlePro_quei_feet">feet</p>
                                    </div>
                                </div>

                                <div class="_singlePro_que_button">
                                    <!-- <button @click="addCart" class="_1btn _btn_large" type="button"><i class="fas fa-shopping-cart"></i> Add to Cart</button> -->
                                    <button v-if="authUser.userType == 'user'" @click="addCart" class="_2btn _btn_large" type="button">Checkout</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Slider zoom -->
        </div>
    </div>
</template>

<script>
export default {
    data(){
       return {
           setting: {
                autoplay: false,
                autoplaySpeed: 2000,
                dots: 'none',
                radiusDot: false,
                trigger: 'click',
                arrow: 'hover'
           },
           product: {},
           data : {
                user_id:'',
    			quantity: 1,
                product_id: ''
    	   },
       }
    }, 

    methods : {
        async addCart(){
			if(this.data.quantity == '') return this.e('Quantity is required')
            if(this.data.quantity < 0) return this.e('Quantity can not (-ve) or 0 number')
            this.isAdding = true
			this.data.product_id = this.$route.params.id
			this.data.user_id = this.authUser.id
            if(!this.authUser){
                return window.location = "/login";
            }
            const res = await this.callApi('post', '/app/add_cart', this.data)
			
            if(res.status===201){
				this.s('Add cart has been added successfully!')
				this.addModal = false
				this.data.user_id = ''
				this.data.quantity = ''
				this.data.product_id = ''
                window.location = '/checkOut'
			}else{
				if (res.status == 422) { 
	                for(let i in res.data.errors){
	                	this.e(res.data.errors[i][0])
	                } 
				}else{
					this.swr()
				}
			}
            this.isAdding = false
		},
    },

    async created(){
        const res = await this.callApi('get', `/app/get_product_details/${this.$route.params.id}`)
        if (res.status === 200) {
            this.product = res.data
        }else{
            this.swr()
        }
    }
}
</script>