<template>
  <div>
    <div class="_2main_content">
      <div class="container">
        <div class="_checkout_table">
          <table id="shopping-cart-table" class="shopping-cart-table-data">
            <thead>
              <tr>
                <th></th>
                <th><span>product name</span></th>
                <th><span class="text-center">unit price</span></th>
                <th><span class="text-center">qty</span></th>
                <th><span class="text-center">subtotal</span></th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              <tr v-if="addCard && addCard.product">
                <td>
                  <div style="width: 200px" class="_cal">
                    <Carousel
                      :autoplay="setting.autoplay"
                      :autoplay-speed="setting.autoplaySpeed"
                      :dots="setting.dots"
                      :radius-dot="setting.radiusDot"
                      :trigger="setting.trigger"
                      :arrow="setting.arrow"
                    >
                      <CarouselItem
                        v-for="(item2, index) in addCard.product.images"
                        :key="index"
                      >
                        <img class="" :src="item2.image" alt="" title="" />
                      </CarouselItem>
                    </Carousel>
                  </div>
                </td>
                <td>
                  <p class="cart-product-name text-overflow2">
                    {{ addCard.product.name }}
                  </p>
                </td>
                <td>
                  <span class="cart-product-price text-center"
                    >{{ addCard.product.price }} / feet</span
                  >
                </td>
                <td>
                  <div v-if="isQty" class="_qty_save">
                    <InputNumber style="width:100px; display:inline-block" :min="1" v-model="editData.quantity" placeholder="--"></InputNumber>
                    <i @click="editQty" class="fas fa-save"></i>
                    <i @click="isQty = false" style="color:red" class="fas fa-times"></i>
                  </div>
                  <p v-else class="cart-product-price text-overflow2">
                    {{ addCard.quantity }}
                  </p>
                </td>
                <td>
                  <span class="cart-product-subtotal text-center">{{
                    addCard.product.price * addCard.quantity
                  }}</span>
                </td>
                <td>
                  <p class="cart-product-icon text-center">
                    <i @click="isQty = true" style="color: green" class="far fa-edit"></i>
                    <!-- <i style="color: red" class="far fa-trash-alt"></i> -->
                  </p>
                </td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="50" class="text-right">
                  <h3 class="">Total : {{ totalPrice }}</h3>
                </td>
              </tr>
            </tfoot>
          </table>
        </div>

        <div class="_checkout_form">
          <div class="row justify-content-center">
            <div class="col-12 col-md-7 col-lg-7">
              <div class="row">
                <div class="col-12 col-md-6 col-lg-6">
                  <div class="_1input_group">
                    <p class="_1label">First Name</p>
                    <Input v-model="data.firstName" placeholder="First Name" />
                  </div>
                </div>
                <div class="col-12 col-md-6 col-lg-6">
                  <div class="_1input_group">
                    <p class="_1label">Last Name</p>
                    <Input v-model="data.lastName" placeholder="Last Name" />
                  </div>
                </div>
                <div class="col-12 col-md-12 col-lg-12">
                  <div class="_1input_group">
                    <p class="_1label">Address</p>
                    <Input v-model="data.address" placeholder="Address" />
                  </div>
                </div>
                <div class="col-12 col-md-12 col-lg-12">
                  <div class="_1input_group">
                    <p class="_1label">Phone</p>
                    <Input v-model="data.phone" placeholder="Phone" />
                  </div>
                </div>

                <div class="col-12 col-md-12 col-lg-12">
                  <div class="_1input_group">
                    <p class="_1label">Checkout</p>
                    <RadioGroup v-model="data.paymentType">
                      <Radio value="cash only" label="cash only"
                        >Cash Payment</Radio
                      >
                      <Radio value="bank" label="bank">Bank Payment</Radio>
                      <Radio value="bank" label="bank">Bank App Payment</Radio>
                    </RadioGroup>
                    <Select v-if="data.paymentType == 'bank'" class="_mar_t10">
                      <Option value="Pubali Bank">Pubali Bank (174390101966)</Option>
                      <Option value="Sonali Bank">Sonali Bank (5633302000171)</Option>
                      <Option value="Bank Asia">Bank Asia (01933001870)</Option>
                      <Option value="Islami Bank">Islami Bank (20507770104475817)</Option>
                      <Option value="Uttara Bank">Uttara Bank (050112200000670)</Option>
                    </Select>
                  </div>
                </div>

                <!-- <div class="col-12 col-md-12 col-lg-12">
                  <div class="_singlePro_deli">
                    <div>
                      <RadioGroup v-model="data.delivery_type" vertical>
                        <Radio label="own">
                          <span>Self</span>
                        </Radio>
                        <Radio label="our">
                          <span>Our Delivery service</span>
                        </Radio>
                      </RadioGroup>
                    </div>

                    <div
                      v-if="data.delivery_type == 'our'"
                      class="_singlePro_deli_main"
                    >
                      <p class="_singlePro_deli_title">Choose youe truck</p>

                      <RadioGroup vertical>
                        <Radio label="2 ton truck">
                          <span>2 ton truck</span>
                        </Radio>
                        <Radio label="3 ton truck">
                          <span>3 ton truck</span>
                        </Radio>
                        <Radio label="5 ton truck">
                          <span>5 ton truck</span>
                        </Radio>
                      </RadioGroup>

                      <p class="_singlePro_deli_cost">Tk- 2000</p>
                    </div>
                  </div>
                </div> -->

                <div class="col-12 col-md-12 col-lg-12">
                  <div class="_1group_button _text_center">
                    <button @click="addOrder" class="_2btn _btn_long">
                      Order
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
import _ from "lodash";
export default {
  data() {
    return {
      setting: {
        autoplay: false,
        autoplaySpeed: 2000,
        dots: "none",
        radiusDot: false,
        trigger: "click",
        arrow: "hover",
      },
      addCard: [],
      editData:{
        quantity: 1,
      },
      data: {
        user_id: authUser.id,
        quantity: "",
        price: "",
        subTotal: "",
        delivery_type: "own",
        delivery_status: "",
        delivery_cost: "",
        orderStatus: "",
        firstName: authUser.firstName,
        lastName: authUser.lastName,
        address: authUser.address,
        phone: authUser.phone,
        paymentType: "",
      },
      isQty: false
    };
  },

  methods: {
    async addOrder() {
      if (this.data.firstName.trim() == "")
        return this.e("First Name is required");
      if (this.data.lastName.trim() == "")
        return this.e("Last Name is required");
      if (this.data.address.trim() == "") return this.e("Address is required");
      if (this.data.phone.trim() == "") return this.e("Phone is required");
      if (this.data.paymentType == "")
        return this.e("Choose your Payment Type!");
      if (this.data.delivery_type == "")
        return this.e("Choose your delivery type!");

      this.data.price = this.addCard.product.price;
      this.data.quantity = this.addCard.quantity;
      this.data.subTotal = this.data.price * this.data.quantity;
      this.data.product_id = Number(this.addCard.product_id);
      console.log('yes', this.data)
      const res = await this.callApi("post", "/app/add_order", this.data);
      if (res.status === 201) {
        this.s("Order has been added successfully!");
        this.data = {};
        this.$router.push("/pageOrder");
      } else {
        if (res.status == 422) {
          for (let i in res.data.errors) {
            this.e(res.data.errors[i][0]);
          }
        } else {
          this.swr();
        }
      }
      this.isAdding = false;
    },

    async editQty(){
      if(this.editData.quantity =='') return this.e('Order Status is required')
      if(this.editData.quantity < 0) return this.e('Quantity can not (-ve) or 0 number')
      this.editData.id = this.addCard.id;
      const res = await this.callApi('post', '/app/update_qty', this.editData)

			if(res.status===200){
				this.addCard.quantity = this.editData.quantity
				this.data.quantity = this.editData.quantity
				this.s('Quantity status has been edited successfully!')
        this.isQty = false
			}else{
				if (res.status == 422) {
					 for(let i in res.data.errors){
	                	this.e(res.data.errors[i][0])
	                } 
				}else{
					this.swr()
				}
			}
    }
  },

  computed: {
    totalPrice() {
      let count = 0;
      if (_.isEmpty(this.addCard)) return count;
      count += this.addCard.product.price * this.addCard.quantity;
      return count;
    },
  },

  async created() {
    const res = await this.callApi("get", `/app/get_add_cart`);
    if (res.status === 200) {
      this.addCard = res.data;
    } else {
      this.swr();
    }
  },
};
</script>