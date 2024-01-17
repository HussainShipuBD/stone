<template>
    <div>
        <div class="_1main_content">
            <div class="_explore">
                <div class="container">
                    <h2 v-if="category" class="_1title _text_center _mar_b20">{{ category.name }}</h2>

                    <p v-if="subCategory && !subCategory.length" class="_text_center _no_data">No Sub Category found!</p>

                    <div v-else class="row">
                        <div v-for="(item, index) in subCategory" :key="index" class="col-12 col-md-3 col-lg-3 _mar_b30">
                            <div @click="clickMenu(item.id)" class="_1card"><p class="_1card_title">{{ item.name }}</p></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>


<script>
export default {
    data(){
       return {
           subCategory: [],
           category: {}
       }
    }, 

    methods : {
        clickMenu(id){
           // $router.push('/pageProduct/'+id)
            window.location = '/pageProduct/'+id
        },

        async getSubCategory(){
            const res = await this.callApi('get', `/app/get_SubCategory/${this.$route.params.id}`)
            if (res.status === 200) {
                this.subCategory = res.data
                // this.addModal = false
            }else{
                this.swr()
            }
        },

        async getCategory() {
            const res = await this.callApi('get', `/app/get_category_subPage/${this.$route.params.id}`)
    	    if (res.status === 200) {
    		    this.category = res.data
    		// this.addModal = false
    	    }else{
    		    this.swr()
    	    }
        }
    },

    async created(){
        this.getSubCategory()
        this.getCategory()
    }
}
</script>