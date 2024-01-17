<template>
    <div>
        <div class="_main_content">
            <div class="_box _b_radious3 _padd20">
                <div class="_1card_top _mar_b20">
                    <div class="_1card_top_left">
                        <p class="_1card_top_title">All Category</p>
                    </div>
                    <div class="_1card_top_right">
                        <ul class="_1card_top_right_list">
                            <li>
                                <Button @click="addModal = true" type="primary">Add Category</Button>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="_table_responsive">
                    <table class="_1table">
                        <tr>
                            <th>No</th>
                            <th>Name</th>
                            <th></th>
                        </tr>
                        
                        <tr v-if="category && !category.length">
                            <td class="_text_center" colspan="3">No data</td>
                        </tr>

                        <tr v-else v-for="(item, index) in category" :key="index">
                            <td>{{ index+1 }}</td>
                            <td>{{ item.name }}</td>
                            <td>
                                <Button @click="showEditModal(item, index)" type="success">Edit</Button>
                                <Button @click="$router.push('/admin/subCategory/'+item.id)" type="primary">Sub categories</Button>
                                <Poptip
                                    placement="top-end"
                                    confirm
                                    title="Are you sure you want to delete this item?"
                                    @on-ok="deleteCategory(item, index)">
                                    <Button type="error">Delete</Button>
                                </Poptip>
                                <!-- <Button @click="deleteAdmin(item, index)" :loading="item.isDeleting" type="error">Delete</Button> -->
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <!-- Add modal -->
		<Modal
        v-model="addModal"
        title="Add Category"
        :mask-closable="false"
        :closable="false">
        	<div>
                <div class="_1input_group">
                    <p class="_1label">Category Name</p>
        		    <Input v-model="data.name" type="text" placeholder="Category name"/>
                </div>
        	</div>

	        <div slot="footer">
	        	<Button @click="addModal = false">Close</Button>
	        	<Button @click="addCategory" :disabled="isAdding" :loading="isAdding" type="info">{{ isAdding ? 'Adding...' : 'Add'}}</Button>
	        </div>
	    </Modal>
	    <!-- Add modal -->

        <!-- Edit modal -->
		<Modal
        v-model="editModal"
        title="Edit Category"
        :mask-closable="false"
        :closable="false">
        	<div>
                <div class="_1input_group">
                    <p class="_1label">Category Name</p>
        		    <Input v-model="editData.name" type="text" placeholder="Category name"/>
                </div>
        	</div>

	        <div slot="footer">
	        	<Button @click="closeEditModal">Close</Button>
	        	<Button @click="editCategory" :disabled="isAdding" :loading="isAdding" type="info">{{ isAdding ? 'Editing...' : 'Save'}}</Button>
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
    			name: ''
    		},
            editData : {
    			name: ''
    		},
            category: [],
            editModal: false,
    		index : -1,
            tokon: '',
            isAdding: false,
            isImage: true,
            isEditItem: false,
            isChangePass: false,
			deletingIndex: -1,
			deleteItem: {},
            isDeleting: false,
            // catStoreS: []
    	}
    },

    methods : {
    	async addCategory(){
			if(this.data.name.trim()=='') return this.e('Category name is required')

            this.isAdding = true
			
            const res = await this.callApi('post', '/app/add_category', this.data)
			
            if(res.status===201){
				this.category.unshift(res.data)
                // this.$store.commit('changeTopic', res.data)
				this.s('Category has been added successfully!')
				this.addModal = false
				this.data.name = ''
                // console.log(this.catStoreS, 'ok')
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

        async editCategory(){
			if(this.editData.name.trim()=='') return this.e('Category name is required')

            this.isAdding=true
            const res = await this.callApi('post', '/app/edit_category', this.editData)

			if(res.status===200){
				this.category[this.index] = this.editData
				this.s('Category has been edited successfully!')
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

        async deleteCategory(item, index){
            this.isDeleing = true
            const res = await this.callApi('post', '/app/delete_category', item)
            if (res.status === 200) {
                this.category.splice(index,1)
                this.i('Category has been deleted successfully!')
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
            this.isEditItem = true
		},

        closeEditModal(){
            this.isEditItem = false
            this.editModal = false
        },

        handleSuccess (res, file) {
            res = `/uploads/${res}`
            if (this.isEditItem) {
                this.editData.image = res
            }
            this.data.image = res
        },

		handleError (res, file) {
			console.log('res', res)
           this.$Notice.warning({
                title: 'The file format is incorrect',
                desc: `${file.errors.file.length ? file.errors.file[0] : "Something went wrong!"}`
            });
        },

        handleFormatError (file) {
            this.$Notice.warning({
                title: 'The file format is incorrect',
                desc: 'File format of ' + file.name + ' is incorrect, please select jpg or png.'
            });
        },

        handleMaxSize (file) {
            this.$Notice.warning({
                title: 'Exceeding file size limit',
                desc: 'File  ' + file.name + ' is too large, no more than 2M.'
            });
        },

        async deleteImage(isAdd){
            let image
            if ( isAdd == 1 ) {
                image = this.data.image
                this.data.image = ''
                this.$refs.uploads.clearFiles()
            }
            else{
                // // for editing
                // this.isImage = true
                // image = this.editData.iconImage
                // this.editData.iconImage = ''
                // this.$refs.editDataUploads.clearFiles()
            }
        	
        	const res = await this.callApi("post", "delete_image", {imageName: image});
		    if (res.status != 200) {
		        this.data.image = image;
		        this.swr();
		    }
		},
    },

    computed: {
    	// ...mapGetters({
    	// 	'catStoreS' : 'getCat'
    	// })
    },

    async created(){
    	this.token = window.Laravel.csrfToken;
        const res = await this.callApi('get', '/app/get_category')
    	if (res.status === 200) {
    		this.category = res.data
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