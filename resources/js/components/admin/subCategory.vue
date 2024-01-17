<template>
    <div>
        <div class="_main_content">
            <div class="_box _b_radious3 _padd20">
                <div class="_1card_top _mar_b20">
                    <div class="_1card_top_left">
                        <p class="_1card_top_title">All Sub-category</p>
                    </div>
                    <div class="_1card_top_right">
                        <ul class="_1card_top_right_list">
                            <li>
                                <Button @click="addModal = true" type="primary">Add Sub-category</Button>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="_table_responsive">
                    <table class="_1table">
                        <tr>
                            <th>No</th>
                            <th>Category</th>
                            <th>Name</th>
                            <th></th>
                        </tr>
                        
                        <tr v-if="subCategory && !subCategory.length">
                            <td class="_text_center" colspan="10">No data</td>
                        </tr>

                        <tr v-for="(item, index) in subCategory" :key="index">
                            <td>{{ index+1 }}</td>
                            <td>{{ category.name }}</td>
                            <td>{{ item.name }}</td>
                            <td>
                                <Button @click="showEditModal(item, index)" type="success">Edit</Button>
                                <Poptip
                                    placement="top-end"
                                    confirm
                                    title="Are you sure you want to delete this item?"
                                    @on-ok="deleteAdmin(item, index)">
                                    <Button type="error">Delete</Button>
                                </Poptip>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <!-- Add modal -->
		<Modal
        v-model="addModal"
        title="Add Sub Category"
        :mask-closable="false"
        :closable="false">
        	<div>
                <div class="_1input_group">
                    <p class="_1label">Sub Category Name</p>
        		    <Input v-model="data.name" type="text" placeholder="Sub Category name"/>
                </div>
        	</div>

	        <div slot="footer">
	        	<Button @click="addModal = false">Close</Button>
	        	<Button @click="addSubCategory" :disabled="isAdding" :loading="isAdding" type="info">{{ isAdding ? 'Adding...' : 'Add'}}</Button>
	        </div>
	    </Modal>
	    <!-- Add modal -->

        <!-- Edit modal -->
		<Modal
        v-model="editModal"
        title="Edit Sub Category"
        @closable="false">
        	<div>
                <div class="_1input_group">
                    <p class="_1label">Sub Category Name</p>
        		    <Input v-model="editData.name" type="text" placeholder="Sub Category name"/>
                </div>
        	</div>

	        <div slot="footer">
	        	<Button @click="closeEditModal">Close</Button>
	        	<Button @click="editAdmin" :disabled="isAdding" :loading="isAdding" type="info">{{ isAdding ? 'Editing...' : 'Save'}}</Button>
	        </div>
	    </Modal>
	    <!-- Edit modal -->
    </div>
</template>


<script>

export default {
    data() {
    	return {
    		addModal: false,
    		data : {
    			name: '',
                category_id: ''
    		},
            editData : {
    			name: '',
                category_id: ''
    		},
            subCategory: [],
            category: {},
            editModal: false,
    		index : -1,
            isAdding: false,
			deletingIndex: -1,
			deleteItem: {},
            isDeleting: false 
    	}
    },

    methods : {
    	async addSubCategory(){
			if(this.data.name.trim()=='') return this.e('Category name is required')

            this.isAdding = true
			
            this.data.category_id = this.$route.params.id

            const res = await this.callApi('post', '/app/add_subCategory', this.data)
			
            if(res.status===201){
                // let data = res.data
                // let obj = {
				//     id : res.data.id,
				//     name : res.data.name,
                //     category : 'this.'
			    // }
				this.subCategory.unshift(res.data)
				this.s('Sub Category has been added successfully!')
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

        async editAdmin(){
            if(this.editData.name.trim()=='') return this.e('Sub Category name is required')

			this.isAdding=true

            const res = await this.callApi('post', '/app/edit_sub_category', this.editData)

			if(res.status===200){
				this.subCategory[this.index].name = this.editData.name
				this.s('Sub Category has been edited successfully!')
				this.editModal = false
			}else{
				if (res.status == 422) {
					 for(let i in res.data.errors){
	                	this.e(res.data.errors[i][0])
	                } 
				}else{
					this.swr()
				}
			}

            this.isAdding=false
		},

        async deleteAdmin(item, index){
            this.isDeleing = true
            const res = await this.callApi('post', '/app/delete_sub_category', item)
            if (res.status === 200) {
                this.subCategory.splice(index,1)
                this.i('Sub Category has been deleted successfully!')
            }else{
                this.swr()
            }
            this.isDeleing = false
		},

        showEditModal(item, index){
			let obj = {
				id : item.id,
				name : item.name
			}
			this.editData = obj
			this.editModal = true
			this.index = index
		},

        closeEditModal(){
            this.editModal = false
        },
    },

    async created(){
        const res = await this.callApi('get', `/app/get_SubCategory/${this.$route.params.id}`)
    	if (res.status === 200) {
    		this.subCategory = res.data
    		// this.addModal = false
    	}else{
    		this.swr()
    	}
        const res2 = await this.callApi('get', `/app/get_category_subPage/${this.$route.params.id}`)
    	if (res2.status === 200) {
    		this.category = res2.data
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