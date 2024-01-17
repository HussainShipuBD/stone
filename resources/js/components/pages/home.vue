<template>
    <div>
        <div class="_main_content">
            <div class="_box _b_radious3 _padd20">
                <div class="_1card_top _mar_b20">
                    <div class="_1card_top_left">
                        <p class="_1card_top_title">All Admin</p>
                    </div>
                    <div class="_1card_top_right">
                        <ul class="_1card_top_right_list">
                            <li>
                                <Button @click="addModal = true" type="primary">Add admin</Button>
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
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Admin type</th>
                            <th></th>
                        </tr>

                        <tr v-if="users && !users.length">
                            <td class="_text_center" colspan="7">No data</td>
                        </tr>

                        <tr v-else v-for="(item, index) in users" :key="index">
                            <td>{{ index+1 }}</td>
                            <td>{{item.firstName}} {{item.lastName}}</td>
                            <td>
                                <img class="_1table_img" v-if="item.image" :src="item.image" alt="" title="">
                            </td>
                            <td>{{ item.email }}</td>
                            <td>{{ item.phone }}</td>
                            <td>{{ item.userType }}</td>
                            <td>
                                <Button @click="showEditModal(item, index)" type="success">Edit</Button>
                                <Poptip
                                    placement="top-end"
                                    confirm
                                    title="Are you sure you want to delete this item?"
                                    @on-ok="deleteAdmin(item, index)">
                                    <Button type="error">Delete</Button>
                                </Poptip>
                                <!-- <Button size="small" @click="deleteAdmin(item, index)" :loading="item.isDeleting" type="error">Delete</Button> -->
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

        <!-- Add modal -->
		<Modal
        v-model="addModal"
        title="Add Admin"
        @closable="false">
        	<div>
                <div class="_1input_group">
                    <p class="_1label">First name</p>
        		    <Input v-model="data.firstName" type="text" placeholder="First name"/>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Last name</p>
        		    <Input v-model="data.lastName" type="text" placeholder="Last name"/>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Image</p>
        		    <Upload
                        v-show="isImage"
                        ref="uploads"
                        type="drag"
                        :headers="{'x-csrf-token' : token, 'X-Requested-With' : 'XMLHttpRequest'}"
                        :on-success="handleSuccess"
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
                    <p class="_1label">Email</p>
        		    <Input v-model="data.email" type="text" placeholder="Email"/>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Phone number</p>
        		    <Input v-model="data.phone" type="text" placeholder="Phone number"/>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Password</p>
        		    <Input v-model="data.password" type="password" placeholder="Password"/>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Confirm password</p>
        		    <Input v-model="data.confirmPassword" type="password" placeholder="Confirm password"/>
                </div>
        	</div>

	        <div slot="footer">
	        	<Button @click="addModal = false">Close</Button>
	        	<Button @click="addAdmin" :disabled="isAdding" :loading="isAdding" type="info">{{ isAdding ? 'Adding...' : 'Add'}}</Button>
	        </div>
	    </Modal>
	    <!-- Add modal -->

        <!-- Edit modal -->
		<Modal
        v-model="editModal"
        title="Edit Admin"
        @closable="false">
        	<div>
                <div class="_1input_group">
                    <p class="_1label">First name</p>
        		    <Input v-model="editData.firstName" type="text" placeholder="First name"/>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Last name</p>
        		    <Input v-model="editData.lastName" type="text" placeholder="Last name"/>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Image</p>
        		    <Upload
                        v-show="isImage"
                        ref="uploads"
                        type="drag"
                        :headers="{'x-csrf-token' : token, 'X-Requested-With' : 'XMLHttpRequest'}"
                        :on-success="handleSuccess"
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
                            <!-- <div class="demo-upload-list-cover">
                                <Icon type="ios-trash-outline" @click="deleteImage(1)"></Icon>
                            </div> -->
                        </template>
                    </div>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Email</p>
        		    <Input v-model="editData.email" type="text" placeholder="Email"/>
                </div>
                <div class="_1input_group">
                    <p class="_1label">Phone number</p>
        		    <Input v-model="editData.phone" type="text" placeholder="Phone number"/>
                </div>

                <p class="_newpass _mar_b10"><span @click="isChangePass = !isChangePass" class="_1link">Change password</span></p>

                <template v-if="isChangePass">
                    <div class="_1input_group">
                        <p class="_1label">Password</p>
                        <Input v-model="editData.password" type="password" placeholder="New password"/>
                    </div>
                    <div class="_1input_group">
                        <p class="_1label">Confirm password</p>
                        <Input v-model="editData.confirmPassword" type="password" placeholder="Confirm new password"/>
                    </div>
                </template>
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
    			firstName: '',
    			lastName: '',
    			phone: '',
                image: '',
    			email: '',
    			password: '',
                confirmPassword: ''
    		},
            editData : {
    			firstName: '',
    			lastName: '',
    			phone: '',
                image: '',
    			email: '',
    			password: '',
                confirmPassword: ''
    		},
            users: [],
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
    	async addAdmin(){
			if(this.data.firstName.trim()=='') return this.e('First name is required')
			if(this.data.lastName.trim()=='') return this.e('Last name is required')
			if(this.data.phone.trim()=='') return this.e('Phone is required')
			if(this.data.image.trim()=='') return this.e('Image is required')
			if(this.data.email.trim()=='') return this.e('Email is required')
			if(this.data.password.trim()=='') return this.e('Password is required')
			if(this.data.confirmPassword.trim()=='') return this.e('Confirm password is required')
    		if(this.data.password != this.data.confirmPassword){
                this.i("The password confirmation does not match.");
                return;
            }

            delete this.data.confirmPassword;
            this.isAdding = true
			
            const res = await this.callApi('post', '/app/create_admin', this.data)
			
            if(res.status===201){
				this.users.unshift(res.data)
				this.s('Admin has been added successfully!')
				this.addModal = false
				this.data.firstName = ''
				this.data.lastName = ''
				this.data.phone = ''
				this.data.image = ''
				this.data.email = ''
				this.data.password = ''
				this.data.confirmPassword = ''
                this.$refs.uploads.clearFiles()
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
			if(this.editData.firstName.trim()=='') return this.e('First name is required')
			if(this.editData.lastName.trim()=='') return this.e('Last name is required')
			if(this.editData.phone.trim()=='') return this.e('Phone is required')
			if(this.editData.image.trim()=='') return this.e('Image is required')
			if(this.editData.email.trim()=='') return this.e('Email is required')
            if(this.editData.password != this.editData.confirmPassword){
                this.i("The password confirmation does not match.");
                return;
            }

            delete this.editData.confirmPassword;
			this.isAdding=true

            const res = await this.callApi('post', '/app/edit_admin', this.editData)

			if(res.status===200){
				this.users[this.index] = this.editData
				this.s('Admin has been edited successfully!')
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

    async created(){
    	this.token = window.Laravel.csrfToken;
        const res = await this.callApi('get', '/app/get_admin')
    	if (res.status === 200) {
    		this.users = res.data
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