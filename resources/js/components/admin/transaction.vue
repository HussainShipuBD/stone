<template>
  <div>
    <div class="_main_content">
      <div class="_box _b_radious3 _padd20">
        <div class="_1card_top _mar_b20">
          <div class="_1card_top_left">
            <p class="_1card_top_title">All Transaction</p>
            <div class="_1card_top_left_search">
              <Input
                @on-change="selectFranchise"
                v-model="str"
                placeholder="Search.."
                style="width: 250px"
              />
            </div>
          </div>
          <div class="_1card_top_right">
            <ul class="_1card_top_right_list">
              <li>
                <Button @click="addModal = true" type="primary"
                  >Add Vendor</Button
                >
              </li>
            </ul>
          </div>
        </div>

        <div class="_table_responsive">
          <table class="_1table">
            <tr>
              <th>No</th>
              <th>Customer name</th>
              <th>Product name</th>
              <th>Product price</th>
              <th>Quantity</th>
              <th>Address</th>
              <th>phone</th>
              <th>Total</th>
            </tr>

            <tr v-if="transaction && !transaction.length">
              <td class="_text_center" colspan="10">No data</td>
            </tr>

            <tr v-else v-for="(item, index) in transaction" :key="index">
              <td>{{ index + 1 }}</td>
              <td>{{ item.firstName }} {{ item.lastName }}</td>
              <td>{{ item.product.name }}</td>
              <td>{{ item.product.price }}</td>
              <td>{{ item.quantity }}</td>
              <td>{{ item.address }}</td>
              <td>{{ item.phone }}</td>
              <td>{{ item.subTotal }}</td>
            </tr>
          </table>
        </div>
      </div>
    </div>
  </div>
</template>


<script>
export default {
  data() {
    return {
      transaction: [],
      str: "",
    };
  },

  methods: {
    async selectFranchise() {
      // const res = await this.callApi('get', '/app/get_driver')
      const res = await this.callApi(
        "get",
        `/app/get_transaction?str=${this.str}`
      );
      if (res.status === 200) {
        this.transaction = res.data;
        // this.addModal = false
      } else {
        this.swr();
      }
    },
  },

  async created() {
    if (this.authUser.userType != "superAdmin")
      return this.$router.push("/admin/admin");

    const res = await this.callApi("get", "/app/get_transaction");
    if (res.status === 200) {
      this.transaction = res.data;
      // this.addModal = false
    } else {
      this.swr();
    }
  },
};
</script>