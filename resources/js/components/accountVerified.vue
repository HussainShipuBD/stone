<template>
    <div>
        <div class="_login">
            <div class="_login_left">
                <div class="_login_overlay"></div>

                <div class="authentic_nav_logo">
                    <a href="/" class="authentic_nav_logo_a">
                        <!-- <img src="/static/img/logo-icon.png" alt="" title="" class="_navbar_logo_img"> 
                        <img src="/static/img/logo-text.png" alt="" title="" class="_navbar_logo_img_text"> -->
						<h3>Logo Image</h3>
                    </a>
                </div>

                <p class="_login_left_text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam tellus elit.</p>

                <Button type="primary">Learn More</Button>
            </div>

            <div class="_login_right">
                <div class="_login_main">
                    <div class="_login_top _1border_color">
                        <p class="_login_top_text">Account Verification</p>
                    </div>

                    <div class="_login_form">
                        <div class="_1input_group">
							<p class="_1label">Verification code</p>
							<Input @on-enter="submit" v-model="data.accountActivationCode" placeholder="Verification code"/>
						</div>
						<div class="_1input_button">
							<button @click="submit" class="_2btn _btn_long" :disable="loading" :loading="loading">Verification</button>
						</div>
                    </div>

                    <div class="_login_bottom">
                        <p class="_login_do">Send Verification code again in your phone?  <router-link class="_3link _mar_l5" to="/sendAgain">Send</router-link></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
export default {
  data(){
    return{
		data : {
			accountActivationCode: ''
		},
		loading: false
	}
  },

  methods:{
    async submit(){
		if(this.data.accountActivationCode == '') return this.e('Verification code is required')
		this.loading = true
		const res = await this.callApi('post', '/app/verification', this.data)
		if(res.status===200){
			// this.s(res.data.msg)
			this.s("Verification is successful!")
            this.data.accountActivationCode = ''
			window.location = '/login'
		}else{
			if(res.status===401){
				this.i(res.data.msg)
				// this.e(res.data.msg)
			}else if(res.status==422){
				for(let i in res.data.errors){
					this.e(res.data.errors[i][0])
				}
				// this.e("Incorrect login details!")
			}
			else{
				this.swr()
			}
		}
		this.loading = false
	}
  }
}
</script>