<template>
  <div>
    <div class="_main_content">
      <div class="_box _b_radious3 _padd20">
        <div class="_1card_top _mar_b20">
          <div class="_1card_top_left">
            <p class="_1card_top_title">All Orders</p>
          </div>
          <!-- <div class="_1card_top_right">
                        <ul class="_1card_top_right_list">
                            <li>
                                <Button @click="addModal = true" type="primary">Add customer</Button>
                            </li>
                        </ul>
                    </div> -->
        </div>

        <div class="_table_responsive">
          <table class="_1table">
            <tr>
              <th>No</th>
              <th>Customer name</th>
              <th>Product</th>
              <th>Image</th>
              <th>Quantity</th>
              <th>Price</th>
              <th>Sub total</th>
              <th>Status</th>
              <th>Address</th>
              <th>Phone</th>
              <th>Delivery Type</th>
              <th>Delivery Status</th>
              <th>Delivery Cost</th>
              <th>Payment Type</th>
            </tr>

            <tr v-if="orders && !orders.length">
              <td class="_text_center" colspan="15">No data</td>
            </tr>

            <tr v-for="(item, index) in orders" :key="index">
              <td>{{ index + 1 }}</td>
              <td>{{ item.firstName }} {{ item.lastName }}</td>
              <td>{{ item.product.name }}</td>
              <td>
                <div style="width: 200px" class="">
                  <Carousel
                    :autoplay="setting.autoplay"
                    :autoplay-speed="setting.autoplaySpeed"
                    :dots="setting.dots"
                    :radius-dot="setting.radiusDot"
                    :trigger="setting.trigger"
                    :arrow="setting.arrow"
                  >
                    <CarouselItem
                      v-for="(i, index) in item.product.images"
                      :key="index"
                    >
                      <img class="" :src="i.image" alt="" title="" />
                    </CarouselItem>
                  </Carousel>
                </div>
              </td>
              <td>
                <p
                  :class="[
                    item.orderStatus == 'processing' ? '_green' : '',
                    item.orderStatus == 'pending' ? '_red' : '',
                  ]"
                  class="_order_status"
                >
                  <span>{{ item.orderStatus }}</span>
                  <i
                    v-if="item.orderStatus != 'complate'"
                    @click="showEditModal(item, index)"
                    class="fas fa-edit"
                  ></i>
                </p>
              </td>
              <td>{{ item.quantity }}</td>
              <td>{{ item.price }}</td>
              <td>{{ item.subTotal }}</td>
              <td>{{ item.address }}</td>
              <td>{{ item.phone }}</td>
              <td>{{ item.delivery_type }}</td>
              <td>
                {{ item.delivery_status }}
              </td>
              <td>
                {{ item.delivery_cost ? item.delivery_cost : 0 }}
                <p class="_order_status">
                  <i
                    @click="showEditModalDelivery(item, index)"
                    class="fas fa-edit"
                  ></i>
                </p>
              </td>
              <td>{{ item.paymentType }}</td>
              <!-- <td>
                                <Button @click="showEditModal(item, index)" type="success">Edit</Button>
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

    <!-- Edit modal -->
    <Modal
      v-model="editModal"
      title="Edit Order"
      :mask-closable="false"
      :closable="false"
    >
      <div>
        <div class="_1input_group">
          <Select v-model="editData.orderStatus">
            <Option value="pending">Pending</Option>
            <Option value="processing">Processing</Option>
            <Option value="complate">Complate</Option>
            <Option value="reject">Reject</Option>
          </Select>

          <template v-if="editData.orderStatus == 'reject'">
            <p class="my-2">Reason</p>
            <Input
              v-model="editData.reason"
              type="textarea"
              :rows="10"
              placeholder="Enter something..."
            />
          </template>
        </div>
      </div>

      <div slot="footer">
        <Button @click="closeEditModal">Close</Button>
        <Button
          @click="editOrderStatus"
          :disabled="isAdding"
          :loading="isAdding"
          type="info"
          >{{ isAdding ? "Editing..." : "Save" }}</Button
        >
      </div>
    </Modal>
    <!-- Edit modal -->

    <!-- Edit delivery price -->
    <Modal
      v-model="editModal2"
      title="Edit Order"
      :mask-closable="false"
      :closable="false"
    >
      <div>
        <div class="_1input_group">
          <label>Delivery Cost</label>
          <Input v-model="editData.delivery_cost"></Input>
        </div>
      </div>

      <div slot="footer">
        <Button @click="closeEditModal">Close</Button>
        <Button
          @click="editOrderDeliveryCost"
          :disabled="isAdding"
          :loading="isAdding"
          type="info"
          >{{ isAdding ? "Editing..." : "Save" }}</Button
        >
      </div>
    </Modal>
    <!-- Edit delivery price -->
  </div>
</template>


<script>
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

      editData: {
        orderStatus: "",
        reason: "",
      },
      orders: [],
      editModal: false,
      editModal2: false,
      index: -1,
      tokon: "",
      isAdding: false,
      isImage: true,
      isEditItem: false,
      deletingIndex: -1,
      deleteItem: {},
      isDeleting: false,
    };
  },

  methods: {
    async editOrderStatus() {
      if (this.editData.orderStatus == "")
        return this.e("Order Status is required");
      this.isAdding = true;

      const res = await this.callApi(
        "post",
        "/app/update_order_status",
        this.editData
      );

      if (res.status === 200) {
        this.orders[this.index].orderStatus = this.editData.orderStatus;
        this.s("Order status has been edited successfully!");
        this.editModal = false;
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
    async editOrderDeliveryCost() {
      if (this.editData.delivery_cost == "" || this.editData.delivery_cost < 0)
        return this.e("Cost is required");
      this.isAdding = true;

      const res = await this.callApi(
        "post",
        "/app/update_order_delivery_cost",
        this.editData
      );

      if (res.status === 200) {
        this.s("Order status has been edited successfully!");
        this.editModal = false;
        this.$router.go();
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

    showEditModal(item, index) {
      let obj = {
        id: item.id,
        orderStatus: item.orderStatus,
      };
      this.editData = obj;
      this.editModal = true;
      this.index = index;
    },

    showEditModalDelivery(item, index) {
      let obj = {
        id: item.id,
        delivery_cost: item.delivery_cost,
      };
      this.editData = obj;
      this.editModal2 = true;
      this.index = index;
    },

    closeEditModal() {
      this.editModal = false;
      this.editModal2 = false;
    },
  },

  async created() {
    this.token = window.Laravel.csrfToken;
    const res = await this.callApi("get", "/app/get_order");
    if (res.status === 200) {
      this.orders = res.data;
      // this.addModal = false
    } else {
      this.swr();
    }
  },
};
</script>