<template>
    <div>
        <div class="_main_content">
            <div class="_box _b_radious3 _padd20">
                <div class="_1card_top _mar_b20">
                    <div class="_1card_top_left">
                        <p class="_1card_top_title">All Vendors</p>
                        <div class="_1card_top_left_search">
                            <Input @on-change="selectFranchise" v-model="str" placeholder="Search.." style="width: 250px;"/>
                        </div>
                    </div>
                    <div class="_1card_top_right">
                        <ul class="_1card_top_right_list">
                            <li>
                                <Button @click="addModal = true" type="primary">Add Vendor</Button>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="_table_responsive">
                    <table class="_1table">
                        <tr>
                            <th>No</th>
                            <th>Name</th>
                            <th>Image</th>
                            <th>NID</th>
                            <th>Trade License</th>
                            <th>Address</th>
                            <th>phone</th>
                            <th>Agreement</th>
                            <th>Banking Number</th>
                            <th></th>
                        </tr>

                        <tr v-if="vendors && !vendors.length">
                            <td class="_text_center" colspan="10">No data</td>
                        </tr>

                        <tr v-else v-for="(item, index) in vendors" :key="index">
                            <td>{{ index+1 }}</td>
                            <td>{{item.name}}</td>
                            <td>
                                <img class="_1table_img" v-if="item.image" :src="item.image" alt="" title="">
                            </td>
                            <td>
                                <img class="_1table_img" style="display: inline-block;" v-if="item.nidFont" :src="item.nidFont" alt="" title="">
                                <img class="_1table_img" style="display: inline-block;" v-if="item.nidBack" :src="item.nidBack" alt="" title="">
                            </td>
                            <td>{{ item.bankingAccount }}</td>
                            <td>{{ item.address }}</td>
                            <td>{{ item.phone }}</td>
                            <td>{{ item.agreement }}</td>
                            <td>{{ item.bankingAccount }}</td>
                            <td>
                                <!-- <Button type="primary"  @click="$router.push('/admin/driverTra/'+item.id)">See all Transaction</Button> -->
                                <Button v-if="authUser.userType == 'superAdmin'" type="primary" @click="$router.push('/admin/vendorTra/'+item.id)">See all Transaction</Button>
                                <Button @click="showEditModal(item, index)" type="success">Edit</Button>
                                <Poptip
                                    placement="top-end"
                                    confirm
                                    title="Are you sure you want to delete this item?"
                                    @on-ok="deleteVendor(item, index)">
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
        title="Add Vendor"
        :mask-closable="false"
        :closable="false">
        	<div>
                <div class="_1input_group">
                    <p class="_1label">Vendor Name</p>
        		    <Input v-model="data.name" type="text" placeholder="Vendor Name"/>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Image</p>
        		    <Upload
                        ref="uploadsPro"
                        type="drag"
                        :headers="{'x-csrf-token' : token, 'X-Requested-With' : 'XMLHttpRequest'}"
                        :on-success="handleSuccessPro"
                        :on-error="handleError"
                        :format="['jpg','jpeg','png']"
                        :max-size="2048"
                        :on-format-error="handleFormatError"
                        :on-exceeded-size="handleMaxSize"
                        action="/upload">
                        <div style="padding: 20px 0">
                            <Icon type="ios-cloud-upload" size="52" style="color: #3399ff"></Icon>
                            <p>Click or drag image here to upload</p>
                        </div>
                    </Upload>

                    <div class="demo-upload-list" v-if="data.image">
                        <template>
                            <img :src="`${data.image}`">
                            <div class="demo-upload-list-cover">
                                <Icon type="ios-trash-outline" @click="deleteImage(1)"></Icon>
                            </div>
                        </template>
                    </div>
                </div>
                <div class="_1input_group">
                    <p class="_1label">NID</p>
                    <div class="row">
                        <div class="col-12 col-md-6 col-lg-6">
                            <Upload
                                ref="uploadsFont"
                                type="drag"
                                :headers="{'x-csrf-token' : token, 'X-Requested-With' : 'XMLHttpRequest'}"
                                :on-success="handleSuccessFont"
                                :on-error="handleError"
                                :format="['jpg','jpeg','png']"
                                :max-size="2048"
                                :on-format-error="handleFormatError"
                                :on-exceeded-size="handleMaxSize"
                                action="/upload">
                                <div style="padding: 20px 0">
                                    <Icon type="ios-cloud-upload" size="52" style="color: #3399ff"></Icon>
                                    <p>NID font side image.</p>
                                </div>
                            </Upload>

                            <div class="demo-upload-list" v-if="data.nidFont">
                                <template>
                                    <img :src="`${data.nidFont}`">
                                    <div class="demo-upload-list-cover">
                                        <Icon type="ios-trash-outline" @click="deleteImage(2)"></Icon>
                                    </div>
                                </template>
                            </div>
                        </div>

                        <div class="col-12 col-md-6 col-lg-6">
                            <Upload
                                ref="uploadsBack"
                                type="drag"
                                :headers="{'x-csrf-token' : token, 'X-Requested-With' : 'XMLHttpRequest'}"
                                :on-success="handleSuccessBack"
                                :on-error="handleError"
                                :format="['jpg','jpeg','png']"
                                :max-size="2048"
                                :on-format-error="handleFormatError"
                                :on-exceeded-size="handleMaxSize"
                                action="/upload">
                                <div style="padding: 20px 0">
                                    <Icon type="ios-cloud-upload" size="52" style="color: #3399ff"></Icon>
                                    <p>NID back side image.</p>
                                </div>
                            </Upload>

                            <div class="demo-upload-list" v-if="data.nidBack">
                                <template>
                                    <img :src="`${data.nidBack}`">
                                    <div class="demo-upload-list-cover">
                                        <Icon type="ios-trash-outline" @click="deleteImage(3)"></Icon>
                                    </div>
                                </template>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Trade License </p>
        		    <Input v-model="data.tradeLicense" type="text" placeholder="Trade License"/>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Address</p>
        		    <Input v-model="data.address" type="text" placeholder="Address"/>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Phone</p>
        		    <Input v-model="data.phone" type="text" placeholder="Phone"/>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Agreement</p>
        		    <Input v-model="data.agreement" type="textarea" :rows="6" placeholder="Agreement"/>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Banking Account</p>
        		    <Input v-model="data.bankingAccount" type="text" placeholder="Banking Account"/>
                </div>
        	</div>

	        <div slot="footer">
	        	<Button @click="addModal = false">Close</Button>
	        	<Button @click="addVendor" :disabled="isAdding" :loading="isAdding" type="info">{{ isAdding ? 'Adding...' : 'Add'}}</Button>
	        </div>
	    </Modal>
	    <!-- Add modal -->

        <!-- Edit modal -->
		<Modal
        v-model="editModal"
        title="Edit Vendor"
        :mask-closable="false"
        :closable="false">
        <div>
            <div class="_1input_group">
                <p class="_1label">Vendor Name</p>
                <Input v-model="editData.name" type="text" placeholder="Vendor Name"/>
            </div>
            <div class="_1input_group">
                <p class="_1label">Image</p>
                <Upload
                    ref="uploadsPro"
                    type="drag"
                    :headers="{'x-csrf-token' : token, 'X-Requested-With' : 'XMLHttpRequest'}"
                    :on-success="handleSuccessPro"
                    :on-error="handleError"
                    :format="['jpg','jpeg','png']"
                    :max-size="2048"
                    :on-format-error="handleFormatError"
                    :on-exceeded-size="handleMaxSize"
                    action="/upload">
                    <div style="padding: 20px 0">
                        <Icon type="ios-cloud-upload" size="52" style="color: #3399ff"></Icon>
                        <p>Click or drag image here to upload</p>
                    </div>
                </Upload>

                <div class="demo-upload-list" v-if="editData.image">
                    <template>
                        <img :src="`${editData.image}`">
                        <div class="demo-upload-list-cover">
                            <Icon type="ios-trash-outline" @click="deleteImage(1)"></Icon>
                        </div>
                    </template>
                </div>
            </div>
            <div class="_1input_group">
                <p class="_1label">NID</p>
                <div class="row">
                    <div class="col-12 col-md-6 col-lg-6">
                        <Upload
                            ref="uploadsFont"
                            type="drag"
                            :headers="{'x-csrf-token' : token, 'X-Requested-With' : 'XMLHttpRequest'}"
                            :on-success="handleSuccessFont"
                            :on-error="handleError"
                            :format="['jpg','jpeg','png']"
                            :max-size="2048"
                            :on-format-error="handleFormatError"
                            :on-exceeded-size="handleMaxSize"
                            action="/upload">
                            <div style="padding: 20px 0">
                                <Icon type="ios-cloud-upload" size="52" style="color: #3399ff"></Icon>
                                <p>NID font side image.</p>
                            </div>
                        </Upload>

                        <div class="demo-upload-list" v-if="editData.nidFont">
                            <template>
                                <img :src="`${editData.nidFont}`">
                                <div class="demo-upload-list-cover">
                                    <Icon type="ios-trash-outline" @click="deleteImage(2)"></Icon>
                                </div>
                            </template>
                        </div>
                    </div>

                    <div class="col-12 col-md-6 col-lg-6">
                        <Upload
                            ref="uploadsBack"
                            type="drag"
                            :headers="{'x-csrf-token' : token, 'X-Requested-With' : 'XMLHttpRequest'}"
                            :on-success="handleSuccessBack"
                            :on-error="handleError"
                            :format="['jpg','jpeg','png']"
                            :max-size="2048"
                            :on-format-error="handleFormatError"
                            :on-exceeded-size="handleMaxSize"
                            action="/upload">
                            <div style="padding: 20px 0">
                                <Icon type="ios-cloud-upload" size="52" style="color: #3399ff"></Icon>
                                <p>NID back side image.</p>
                            </div>
                        </Upload>

                        <div class="demo-upload-list" v-if="editData.nidBack">
                            <template>
                                <img :src="`${editData.nidBack}`">
                                <div class="demo-upload-list-cover">
                                    <Icon type="ios-trash-outline" @click="deleteImage(3)"></Icon>
                                </div>
                            </template>
                        </div>
                    </div>
                </div>
            </div>
            <div class="_1input_group">
                <p class="_1label">Trade License</p>
                <Input v-model="editData.tradeLicense" type="text" placeholder="Trade License"/>
            </div>
            <div class="_1input_group">
                <p class="_1label">Address</p>
                <Input v-model="editData.address" type="text" placeholder="Address"/>
            </div>
            <div class="_1input_group">
                <p class="_1label">Phone</p>
                <Input v-model="editData.phone" type="text" placeholder="Phone"/>
            </div>
            <div class="_1input_group">
                <p class="_1label">Agreement</p>
                <Input v-model="editData.agreement" type="text" placeholder="Agreement"/>
            </div>
            <div class="_1input_group">
                <p class="_1label">Banking Account</p>
                <Input v-model="editData.bankingAccount" type="text" placeholder="Banking Account"/>
            </div>
        </div>

	        <div slot="footer">
	        	<Button @click="closeEditModal">Close</Button>
	        	<Button @click="editVendor" :disabled="isAdding" :loading="isAdding" type="info">{{ isAdding ? 'Editing...' : 'Save'}}</Button>
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
    			image: '',
    			nidFont: '',
    			nidBack: '',
    			tradeLicense: '',
                address: '',
    			phone: '',
                agreement: '',
    			bankingAccount: ''
    		},
            editData : {
    			name: '',
    			image: '',
    			nidFont: '',
    			nidBack: '',
    			tradeLicense: '',
                address: '',
    			phone: '',
                agreement: '',
    			bankingAccount: ''
    		},
            str: '',
            vendors: [],
            editModal: false,
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
    	async addVendor(){
			if(this.data.name.trim()=='') return this.e('Name is required')
			if(this.data.image.trim()=='') return this.e('Image is required')
			if(this.data.nidFont=='') return this.e('NID image is required')
			if(this.data.nidBack=='') return this.e('NID image is required')
			if(this.data.tradeLicense.trim()=='') return this.e('License is required')
			if(this.data.address.trim()=='') return this.e('Address is required')
			if(this.data.phone.trim()=='') return this.e('Phone is required')
			if(this.data.agreement.trim()=='') return this.e('Engine number is required')
			if(this.data.bankingAccount.trim()=='') return this.e('Chasis is required')
    		
            this.isAdding = true
			
            const res = await this.callApi('post', '/app/create_vendor', this.data)
			
            if(res.status===201){
				this.vendors.unshift(res.data)
				this.s('Driver has been added successfully!')
				this.addModal = false
				this.data.name = ''
				this.data.image = ''
				this.data.nidFont = ''
				this.data.nidBack = ''
				this.data.tradeLicense = ''
				this.data.address = ''
				this.data.phone = ''
				this.data.agreement = ''
				this.data.bankingAccount = ''
                this.$refs.uploadsPro.clearFiles()
                this.$refs.uploadsFont.clearFiles()
                this.$refs.uploadsBack.clearFiles()
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

        async editVendor(){
			if(this.editData.name.trim()=='') return this.e('Name is required')
			if(this.editData.image.trim()=='') return this.e('Image is required')
			if(this.editData.nidFont=='') return this.e('NID image is required')
			if(this.editData.nidBack=='') return this.e('NID image is required')
			if(this.editData.tradeLicense.trim()=='') return this.e('License is required')
			if(this.editData.address.trim()=='') return this.e('Address is required')
			if(this.editData.phone.trim()=='') return this.e('Phone is required')
			if(this.editData.agreement.trim()=='') return this.e('Engine number is required')
			if(this.editData.bankingAccount.trim()=='') return this.e('Chasis is required')

			this.isAdding=true

            const res = await this.callApi('post', '/app/edit_vendor', this.editData)

			if(res.status===200){
				this.vendors[this.index] = this.editData
				this.s('Vendor has been edited successfully!')
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

        async deleteVendor(item, index){
            this.isDeleing = true
            const res = await this.callApi('post', '/app/delete_vendor', item)
            if (res.status === 200) {
                this.vendors.splice(index,1)
                this.i('Vendor has been deleted successfully!')
            }else{
                this.swr()
            }
            this.isDeleing = false
		},

        showEditModal(item, index){
			let obj = {
				id : item.id,
				name : item.name,
                image : item.image,
                nidFont : item.nidFont,
                nidBack : item.nidBack,
                tradeLicense : item.tradeLicense,
                address : item.address,
                phone : item.phone,
                agreement : item.agreement,
                bankingAccount : item.bankingAccount,
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

        // handleSuccess (res, file) {
        //     res = `/uploads/${res}`
        //     if (this.isEditItem) {
        //         this.editData.image = res
        //     }
        //     this.data.image = res
        // },

        handleSuccessPro (res, file) {
            res = `/uploads/${res}`
            if (this.isEditItem) {
                this.editData.image = res
            }
            this.data.image = res
        },

        handleSuccessFont (res, file) {
            res = `/uploads/${res}`
            if (this.isEditItem) {
                this.editData.nidFont = res
            }
            this.data.nidFont = res
        },
        
        handleSuccessBack (res, file) {
            res = `/uploads/${res}`
            if (this.isEditItem) {
                this.editData.nidBack = res
            }
            this.data.nidBack = res
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
                this.$refs.uploadsPro.clearFiles()
            }else if ( isAdd == 2 ) {
                image = this.data.nidFont
                this.data.nidFont = ''
                this.$refs.uploadsFont.clearFiles()
            }
            else if ( isAdd == 3 ) {
                image = this.data.nidBack
                this.data.nidBack = ''
                this.$refs.uploadsBack.clearFiles()
            }
        	
        	const res = await this.callApi("post", "/delete_image", {imageName: image});
		    if (res.status != 200) {
		        this.data.image = image;
		        this.data.nidFont = image;
		        this.data.nidBack = image;
		        this.swr();
		    }
		},

        async selectFranchise(){ 
            // const res = await this.callApi('get', '/app/get_driver')
            const res = await this.callApi('get', `/app/get_vendor?str=${this.str}`)
            if (res.status === 200) {
                this.vendors = res.data
                // this.addModal = false
            }else{
                this.swr()
            }
        },
    },

    async created(){
    	this.token = window.Laravel.csrfToken;
        const res = await this.callApi('get', '/app/get_vendor')
    	if (res.status === 200) {
    		this.vendors = res.data
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