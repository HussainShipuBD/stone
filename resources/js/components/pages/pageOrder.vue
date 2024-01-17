<template>
    <div>
        <div class="_1main_content">
            <div class="container">
                <div class="_box _b_radious3 _padd20 _mar_t30 _mar_b30">
                    <h2 v-if="!orders &&  !orders.product" class="_text_center">No orders found!</h2>

                    <div v-else class="_invoice">
                        <div class="_invoice_top">
                            <p class="_invoice_title">Order</p>

                            <p :class="([orders.orderStatus == 'processing'? '_green' : '',  orders.orderStatus == 'pending'? '_red' : ''])" class="_order_status">
                                <span>{{ orders.orderStatus }}</span> 
                            </p>
                        </div>

                        <div class="_invoice_info">
                            <p class="_invoice_info_name">Name</p>
                            <p class="_invoice_info_val">: {{ orders.firstName }} {{ orders.lastName }}</p>
                        </div>
                        <div class="_invoice_info">
                            <p class="_invoice_info_name">Address</p>
                            <p class="_invoice_info_val">: {{ orders.address }}</p>
                        </div>
                        <div class="_invoice_info">
                            <p class="_invoice_info_name">Phone</p>
                            <p class="_invoice_info_val">: {{ orders.phone }}</p>
                        </div>

                        <div class="_invoice_product">
                            <table class="_invoice_product_table">
                                <tr>
                                    <th>Product name</th>
                                    <th>Image</th>
                                    <th>Quantity</th>
                                    <th>Delivery Type</th>
                                    <th>Delivery Status</th>
                                    <th>Delivery Cost</th>
                                    <th>Payment Type</th>
                                </tr>
                                <tr>
                                    <td>{{ orders.product.name }}</td>
                                    <td>
                                        <div style="width:200px" class="">
                                            <Carousel
                                                :autoplay="setting.autoplay"
                                                :autoplay-speed="setting.autoplaySpeed"
                                                :dots="setting.dots"
                                                :radius-dot="setting.radiusDot"
                                                :trigger="setting.trigger"
                                                :arrow="setting.arrow"
                                            >
                                                <CarouselItem v-if="orders.product.images" v-for="(item, index) in orders.product.images" :key="index">
                                                        <img class="" :src="item.image" alt="" title="">
                                                </CarouselItem>
                                            </Carousel>
                                        </div>
                                    </td>

                                    <td>{{ orders.quantity }}</td>
                                    <td>{{ orders.delivery_type }}</td>
                                    <td>{{ orders.delivery_status }}</td>
                                    <td>{{ orders.delivery_cost }}</td>
                                    <td>{{ orders.paymentType }}</td>
                                </tr>
                            </table>
                        </div>

                        <h2 class="_invoice_total">Sub total : {{ orders.subTotal }}</h2>
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
            setting: {
                autoplay: false,
                autoplaySpeed: 2000,
                dots: 'none',
                radiusDot: false,
                trigger: 'click',
                arrow: 'hover'
            },
            orders: []
    	}
    },

    methods : {
        
    },

    async created(){
        const res = await this.callApi('get', '/app/get_page_order')
    	if (res.status === 200) {
    		this.orders = res.data
    		// this.addModal = false
    	}else{
    		this.swr()
    	}
    }
};	
</script>