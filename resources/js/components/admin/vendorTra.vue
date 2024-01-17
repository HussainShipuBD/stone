<template>
    <div>
        <div class="_main_content">
            <div class="_box _b_radious3 _padd20">
                <div class="_1card_top _mar_b20">
                    <div class="_1card_top_left">
                        <p class="_1card_top_title">All</p>
                    </div>
                    <div class="_1card_top_right">
                        <ul class="_1card_top_right_list">
                            <li>
                                <Button @click="addModal = true" type="primary">Paid</Button>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="_driver_pro">
                    <div class="_driver_pro_pic">
                        <img class="_driver_pro_img" :src="vendorPro.image" alt="" title="">
                    </div>
                    <div class="_driver_pro_details">
                        <p class="_driver_pro_name">{{ vendorPro.name }}</p>
                        <p class="_driver_pro_phone">{{ vendorPro.phone }}</p>
                    </div>
                </div>

                <div class="_driver_tra">
                    <h2 class="_driver_tra_text">Total Transaction : {{ total }}</h2>
                    <h2 style="color: green;" class="_driver_tra_text">Total paid : {{ totalPaid }}</h2>
                    <h2 style="color: red;" class="_driver_tra_text">Total due : {{ totalDue }}</h2>
                </div>
                
                <div class="_table_responsive">
                    <table class="_1table">
                        <tr>
                            <th>No</th>
                            <th>Total</th>
                            <th>Paid</th>
                            <th>Due</th>
                            <th>Transaction date</th>
                        </tr>
                        
                        <tr v-if="transetion && !transetion.length">
                            <td class="_text_center" colspan="6">No data</td>
                        </tr>

                        <tr v-for="(item, index) in transetion" :key="index">
                            <td>{{ index+1 }}</td>
                            <td>{{ item.total }}</td>
                            <td>{{ item.paid }}</td>
                            <td>{{ item.due }}</td>
                            <td>{{ item.created_at }}</td>
                            <!-- <td>
                                <Button @click="showEditModal(item, index)" type="success">Edit</Button>
                                <Button type="primary">Add product</Button>
                                <Poptip
                                    placement="top-end"
                                    confirm
                                    title="Are you sure you want to delete this item?"
                                    @on-ok="deleteAdmin(item, index)">
                                    <Button type="error">Delete</Button>
                                </Poptip>
                            </td> -->
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <!-- Add modal -->
		<Modal
        v-model="addModal"
        title="Add Transaction"
        :mask-closable="false"
        :closable="false">
        	<div>
                <div class="_1input_group">
                    <p class="_1label">Total</p>
        		    <Input v-model="data.total" type="text" placeholder="Total"/>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Paid</p>
        		    <Input v-model="data.paid" type="text" placeholder="Paid"/>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Due</p>
        		    <Input v-model="data.due" type="text" placeholder="due"/>
                </div>
        	</div>

	        <div slot="footer">
	        	<Button @click="addModal = false">Close</Button>
	        	<Button @click="addTransaction" :disabled="isAdding" :loading="isAdding" type="info">{{ isAdding ? 'Adding...' : 'Add'}}</Button>
	        </div>
	    </Modal>
	    <!-- Add modal -->
    </div>
</template>


<script>

export default {
    data() {
    	return {
    		addModal: false,
    		data : {
    			vendor_id: '',
                total: '',
                paid: '',
                due: ''
    		},
            transetion: [],
            vendorPro: {},
    		index : -1,
            tokon: '',
            isAdding: false,
            isImage: true,
            isEditItem: false,
            isChangePass: false,
			deletingIndex: -1,
			deleteItem: {},
            isDeleting: false 
    	}
    },

    methods : {
    	async addTransaction(){
			if(this.data.total == '') return this.e('Paid money is required')

            this.isAdding = true
			
            this.data.vendor_id = this.$route.params.id

            const res = await this.callApi('post', '/app/add_vendorTra', this.data)
			
            if(res.status===201){
				this.transetion.unshift(res.data)
				this.s('Transetion has been added successfully!')
				this.addModal = false
				this.data.name = ''
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

        async deleteAdmin(item, index){
            this.isDeleing = true
            const res = await this.callApi('post', '/app/delete_admin', item)
            if (res.status === 200) {
                this.users.splice(index,1)
                this.i('Admin has been deleted successfully!')
            }else{
                this.swr()
            }
            this.isDeleing = false
		},

        showEditModal(item, index){
			let obj = {
				id : item.id,
				firstName : item.firstName,
                lastName : item.lastName,
                phone : item.phone,
                image : item.image,
                email : item.email,
                userType : item.userType
			}
			this.editData = obj
			this.editModal = true
			this.index = index
            this.isEditItem = true
		},

        closeEditModal(){
            this.isEditItem = false
            this.editModal = false
        },
    },

    computed:{
        total(){
            let sumTotal = 0
            for(let i of this.transetion){
                sumTotal += Number(i.total)
            }
            return sumTotal
        },
        totalPaid(){
            let sumPaid = 0
            for(let i of this.transetion){
                sumPaid += Number(i.paid)
            }
            return sumPaid
        },
        totalDue(){
            let sumDue = 0
            for(let i of this.transetion){
                sumDue += Number(i.due)
            }
            return sumDue
        },
        
    },

    async created(){
        const res = await this.callApi('get', `/app/get_vendorPro/${this.$route.params.id}`)
    	if (res.status === 200) {
    		this.vendorPro = res.data
    		// this.addModal = false
    	}else{
    		this.swr()
    	}

        const res2 = await this.callApi('get', `/app/get_vendorTra/${this.$route.params.id}`)
    	if (res2.status === 200) {
    		this.transetion = res2.data
    		// this.addModal = false
    	}else{
    		this.swr()
    	}
    }
};	
</script>
<style scoped>
.demo-upload-list{
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
    box-shadow: 0 1px 1px rgba(0,0,0,.2);
    margin-right: 4px;
}
.demo-upload-list img{
    width: 100%;
    height: 100%;
}
.demo-upload-list-cover{
    display: none;
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    background: rgba(0,0,0,.6);
}
.demo-upload-list:hover .demo-upload-list-cover{
    display: block;
}
.demo-upload-list-cover i{
    color: #fff;
    font-size: 20px;
    cursor: pointer;
    margin: 0 2px;
}
</style>