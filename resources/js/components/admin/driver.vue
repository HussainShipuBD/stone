<template>
    <div>
        <div class="_main_content">
            <div class="_box _b_radious3 _padd20">
                <div class="_1card_top _mar_b20">
                    <div class="_1card_top_left">
                        <p class="_1card_top_title">All Driver</p>
                        <div class="_1card_top_left_search">
                            <Input @on-change="selectFranchise" v-model="str" placeholder="Search.." style="width: 250px;"/>
                        </div>
                    </div>
                    <div class="_1card_top_right">
                        <ul class="_1card_top_right_list">
                            <li>
                                <Button @click="addModal = true" type="primary">Add Driver</Button>
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
                            <th>License</th>
                            <th>Address</th>
                            <th>phone</th>
                            <th>Engine Number</th>
                            <th>Chasis Number</th>
                            <th></th>
                        </tr>

                        <tr v-if="drivers && !drivers.length">
                            <td class="_text_center" colspan="10">No data</td>
                        </tr>

                        <tr v-else  v-for="(item, index) in drivers" :key="index">
                            <td>{{ index+1 }}</td>
                            <td>{{item.name}}</td>
                            <td>
                                <img class="_1table_img" v-if="item.image" :src="item.image" alt="" title="">
                            </td>
                            <td>
                                <img class="_1table_img" style="display: inline-block;" v-if="item.nidFont" :src="item.nidFont" alt="" title="">
                                <img class="_1table_img" style="display: inline-block;" v-if="item.nidBack" :src="item.nidBack" alt="" title="">
                            </td>
                            <td>{{ item.license }}</td>
                            <td>{{ item.address }}</td>
                            <td>{{ item.phone }}</td>
                            <td>{{ item.engineNo }}</td>
                            <td>{{ item.chasisNo }}</td>
                            <td>
                                <!-- <Button type="primary"  @click="$router.push('/admin/driverTra/'+item.id)">See all Transaction</Button> -->
                                <Button v-if="authUser.userType == 'superAdmin'" type="primary" @click="$router.push('/admin/driverTra/'+item.id)">See all Transaction</Button>
                                <Button @click="showEditModal(item, index)" type="success">Edit</Button>
                                <Poptip
                                    placement="top-end"
                                    confirm
                                    title="Are you sure you want to delete this item?"
                                    @on-ok="deleteDriver(item, index)">
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
        title="Add Driver"
        :mask-closable="false"
        :closable="false">
        	<div>
                <div class="_1input_group">
                    <p class="_1label">Driver Name</p>
        		    <Input v-model="data.name" type="text" placeholder="Driver Name"/>
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
                    <p class="_1label">License Number</p>
        		    <Input v-model="data.license" type="text" placeholder="License Number"/>
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
                    <p class="_1label">Engine Number</p>
        		    <Input v-model="data.engineNo" type="text" placeholder="Engine Number"/>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Chasis Number</p>
        		    <Input v-model="data.chasisNo" type="text" placeholder="Chasis Number"/>
                </div>
        	</div>

	        <div slot="footer">
	        	<Button @click="addModal = false">Close</Button>
	        	<Button @click="addDriver" :disabled="isAdding" :loading="isAdding" type="info">{{ isAdding ? 'Adding...' : 'Add'}}</Button>
	        </div>
	    </Modal>
	    <!-- Add modal -->

        <!-- Edit modal -->
		<Modal
        v-model="editModal"
        title="Edit Driver"
        :mask-closable="false"
        :closable="false">
        <div>
            <div class="_1input_group">
                <p class="_1label">Driver Name</p>
                <Input v-model="editData.name" type="text" placeholder="Driver Name"/>
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
                <p class="_1label">License Number</p>
                <Input v-model="editData.license" type="text" placeholder="License Number"/>
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
                <p class="_1label">Engine Number</p>
                <Input v-model="editData.engineNo" type="text" placeholder="Engine Number"/>
            </div>
            <div class="_1input_group">
                <p class="_1label">Chasis Number</p>
                <Input v-model="editData.chasisNo" type="text" placeholder="Chasis Number"/>
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
    			image: '',
    			nidFont: '',
    			nidBack: '',
    			license: '',
                address: '',
    			phone: '',
    			engineNo: '',
                chasisNo:'',
    		},
            editData : {
    			name: '',
    			image: '',
    			nidFont: '',
    			nidBack: '',
    			license: '',
                address: '',
    			phone: '',
    			engineNo: '',
                chasisNo:'',
    		},
            drivers: [],
            str: '',
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
    	async addDriver(){
			if(this.data.name.trim()=='') return this.e('Name is required')
			if(this.data.image.trim()=='') return this.e('Image is required')
			if(this.data.nidFont=='') return this.e('NID image is required')
			if(this.data.nidBack=='') return this.e('NID image is required')
			if(this.data.license.trim()=='') return this.e('License is required')
			if(this.data.address.trim()=='') return this.e('Address is required')
			if(this.data.phone.trim()=='') return this.e('Phone is required')
			if(this.data.engineNo.trim()=='') return this.e('Engine number is required')
			if(this.data.chasisNo.trim()=='') return this.e('Chasis is required')
    		
            this.isAdding = true
			
            const res = await this.callApi('post', '/app/create_driver', this.data)
			
            if(res.status===201){
				this.drivers.unshift(res.data)
				this.s('Driver has been added successfully!')
				this.addModal = false
				this.data.name = ''
				this.data.image = ''
				this.data.nidFont = ''
				this.data.nidBack = ''
				this.data.license = ''
				this.data.address = ''
				this.data.phone = ''
				this.data.engineNo = ''
				this.data.chasisNo = ''
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

        async editAdmin(){
			if(this.editData.name.trim()=='') return this.e('Name is required')
			if(this.editData.image.trim()=='') return this.e('Image is required')
			if(this.editData.nidFont=='') return this.e('NID image is required')
			if(this.editData.nidBack=='') return this.e('NID image is required')
			if(this.editData.license.trim()=='') return this.e('License is required')
			if(this.editData.address.trim()=='') return this.e('Address is required')
			if(this.editData.phone.trim()=='') return this.e('Phone is required')
			if(this.editData.engineNo.trim()=='') return this.e('Engine number is required')
			if(this.editData.chasisNo.trim()=='') return this.e('Chasis is required')

			this.isAdding=true

            const res = await this.callApi('post', '/app/edit_driver', this.editData)

			if(res.status===200){
				this.drivers[this.index] = this.editData
				this.s('Drivers has been edited successfully!')
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

        async deleteDriver(item, index){
            this.isDeleing = true
            const res = await this.callApi('post', '/app/delete_driver', item)
            if (res.status === 200) {
                this.drivers.splice(index,1)
                this.i('Driver has been deleted successfully!')
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
                license : item.license,
                address : item.address,
                phone : item.phone,
                engineNo : item.engineNo,
                chasisNo : item.chasisNo,
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
            }else{
                this.data.image = res
            }
        },

        handleSuccessPro (res, file) {
            res = `/uploads/${res}`
            if (this.isEditItem) {
                this.editData.image = res
            }else{
                this.data.image = res
            }
        },

        handleSuccessFont (res, file) {
            res = `/uploads/${res}`
             if (this.isEditItem) {
                this.editData.nidFont = res
            }else{
                this.data.nidFont = res
            }
        },
        
        handleSuccessBack (res, file) {
            res = `/uploads/${res}`
             if (this.isEditItem) {
                this.editData.nidBack = res
            }else{
                this.data.nidBack = res
            }
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
            const res = await this.callApi('get', `/app/get_driver?str=${this.str}`)
            if (res.status === 200) {
                this.drivers = res.data
                // this.addModal = false
            }else{
                this.swr()
            }
        },
    },

    async created(){
    	this.token = window.Laravel.csrfToken;
        const res = await this.callApi('get', '/app/get_driver')
    	if (res.status === 200) {
    		this.drivers = res.data
    		// this.addModal = false
    	}else{
    		this.swr()
    	}
    },
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