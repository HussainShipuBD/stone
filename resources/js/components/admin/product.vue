<template>
  <div>
    <div class="_main_content">
      <div class="_box _b_radious3 _padd20">
        <div class="_1card_top _mar_b20">
          <div class="_1card_top_left">
            <p class="_1card_top_title">All Product</p>
          </div>
          <div class="_1card_top_right">
            <ul class="_1card_top_right_list">
              <li>
                <Button @click="addModal = true" type="primary"
                  >Add Product</Button
                >
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
              <th>Cetagory</th>
              <th>Sub Cetagory</th>
              <th>Decription</th>
              <th>Price</th>
              <th></th>
            </tr>
            <tr v-for="(item, index) in products" :key="index">
              <td>{{ index + 1 }}</td>
              <td>{{ item.name }}</td>
              <td>
                <span v-for="(item, index) in item.images" :key="index">
                  <img
                    class="_2table_img"
                    v-if="item.image"
                    :src="item.image"
                    alt=""
                    title=""
                  />
                </span>
              </td>
              <td v-if="item.category">{{ item.category.name }}</td>
              <td v-if="item.subcategory">{{ item.subcategory.name }}</td>
              <td style="white-space: normal; min-width:400px">{{ item.description }}</td>
              <td>{{ item.price }}</td>
              <td>
                <Button @click="showEditModal(item, index)" type="success"
                  >Edit</Button
                >
                <Poptip
                  placement="top-end"
                  confirm
                  title="Are you sure you want to delete this item?"
                  @on-ok="deleteProduct(item, index)"
                >
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
      title="Add Product"
      :mask-closable="false"
      :closable="false"
    >
      <div>
        <div class="_1input_group">
          <p class="_1label">Product Name</p>
          <Input v-model="data.name" type="text" placeholder="Product Name" />
        </div>
        <div class="_1input_group">
          <p class="_1label">Category</p>
          <Select
            v-model="data.category_id"
            filterable
            :remote-method="categorySearch"
          >
            <Option
              v-for="(item, index) in category"
              :value="item.id"
              :key="index"
              >{{ item.name }}</Option
            >
          </Select>
        </div>

        <div class="_1input_group">
          <p class="_1label">Subcategory</p>
          <Select
            v-model="data.sub_category_id"
            filterable
            :remote-method="subCategorySearch"
          >
            <Option
              v-for="(item, index) in subCategory"
              :value="item.id"
              :key="index"
              >{{ item.name }}</Option
            >
          </Select>
        </div>
        <div class="_1input_group">
          <p class="_1label">Image</p>
          <Upload
            v-show="isImage"
            ref="uploads"
            type="drag"
            :show-upload-list="false"
            :format="['jpg', 'jpeg', 'png']"
            :max-size="20480"
            :on-success="handleSuccess"
            :on-format-error="handleFormatError"
            :on-exceeded-size="handleMaxSize"
            multiple
            action="/upload"
          >
            <div style="padding: 20px 0">
              <Icon
                type="ios-cloud-upload"
                size="52"
                style="color: #3399ff"
              ></Icon>
              <p>Click or drag image here to upload</p>
            </div>
          </Upload>

          <div
            class="demo-upload-list"
            v-for="(item, index) in imageList"
            :key="index"
          >
            <template v-if="item.image">
              <img :src="item.image" />
              <div class="demo-upload-list-cover">
                <!-- <Icon type="ios-eye-outline" @click.native="handleView(item.image)"></Icon> -->
                <Icon
                  type="ios-trash-outline"
                  @click.native="handleRemove(i)"
                ></Icon>
              </div>
            </template>
            <template v-else>
              <Progress
                v-if="item.showProgress"
                :percent="item.percentage"
                hide-info
              ></Progress>
            </template>
          </div>

          <!-- <div class="demo-upload-list" v-if="data.image">
                        <template>
                            <img :src="`${data.image}`">
                            <div class="demo-upload-list-cover">
                                <Icon type="ios-trash-outline" @click="deleteImage(1)"></Icon>
                            </div>
                        </template>
                    </div> -->
        </div>
        <div class="_1input_group">
          <p class="_1label">Description</p>
          <Input
            v-model="data.description"
            :rows="6"
            type="textarea"
            placeholder="Description"
          />
        </div>
        <div class="_1input_group">
          <p class="_1label">Price</p>
          <Input v-model="data.price" type="text" placeholder="Price" />
        </div>
      </div>

      <div slot="footer">
        <Button @click="addModal = false">Close</Button>
        <Button
          @click="addProduct"
          :disabled="isAdding"
          :loading="isAdding"
          type="info"
          >{{ isAdding ? "Adding..." : "Add" }}</Button
        >
      </div>
    </Modal>
    <!-- Add modal -->

    <!-- Edit modal -->
    <Modal
      v-model="editModal"
      title="Edit Product"
      :mask-closable="false"
      :closable="false"
    >
      <div>
        <div class="_1input_group">
          <p class="_1label">Product Name</p>
          <Input
            v-model="editData.name"
            type="text"
            placeholder="Product Name"
          />
        </div>
        <div class="_1input_group">
          <p class="_1label">Category</p>
          <!-- :remote-method="categorySearch" -->
          <Select
            v-model="editData.category_id"
            filterable
            :remote-method="categorySearchEdit"
          >
            <Option
              v-for="(item, index) in category"
              :value="item.id"
              :key="index"
              >{{ item.name }}</Option
            >
          </Select>
        </div>

        <div class="_1input_group">
          <p class="_1label">Subcategory</p>
          <Select
            v-model="editData.sub_category_id"
            filterable
            :remote-method="subCategorySearchEdit"
          >
            <Option
              v-for="(item, index) in subCategory"
              :value="item.id"
              :key="index"
              >{{ item.name }}</Option
            >
          </Select>
        </div>
        <div class="_1input_group">
          <p class="_1label">Image</p>
          <Upload
            v-show="isImage"
            ref="uploads"
            type="drag"
            :show-upload-list="false"
            :format="['jpg', 'jpeg', 'png']"
            :max-size="20480"
            :on-success="handleSuccess"
            :on-format-error="handleFormatError"
            :on-exceeded-size="handleMaxSize"
            multiple
            action="/upload"
          >
            <div style="padding: 20px 0">
              <Icon
                type="ios-cloud-upload"
                size="52"
                style="color: #3399ff"
              ></Icon>
              <p>Click or drag image here to upload</p>
            </div>
          </Upload>

          <div
            class="demo-upload-list"
            v-for="(item, index) in imageList"
            :key="index"
          >
            <template v-if="item">
              <img :src="item.image" />
              <div class="demo-upload-list-cover">
                <!-- <Icon type="ios-eye-outline" @click.native="handleView(item.image)"></Icon> -->
                <Icon
                  type="ios-trash-outline"
                  @click.native="handleRemove(i)"
                ></Icon>
              </div>
            </template>
            <template v-else>
              <Progress
                v-if="item.showProgress"
                :percent="item.percentage"
                hide-info
              ></Progress>
            </template>
          </div>
        </div>
        <div class="_1input_group">
          <p class="_1label">Description</p>
          <Input
            v-model="editData.description"
            :rows="6"
            type="textarea"
            placeholder="Description"
          />
        </div>
        <div class="_1input_group">
          <p class="_1label">Price</p>
          <Input v-model="editData.price" type="text" placeholder="Price" />
        </div>
      </div>

      <div slot="footer">
        <Button @click="closeEditModal">Close</Button>
        <Button
          @click="editProduct"
          :disabled="isAdding"
          :loading="isAdding"
          type="info"
          >{{ isAdding ? "Editing..." : "Save" }}</Button
        >
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
      data: {
        name: "",
        category_id: "",
        sub_category_id: "",
        description: "",
        price: "",
        images: [],
      },
      imageList: [],
      editData: {
        name: "",
        category_id: "",
        sub_category_id: "",
        description: "",
        price: "",
        images: [],
      },
      products: [],
      category: [],
      categories: [],
      subCategory: [],
      editModal: false,
      index: -1,
      tokon: "",
      isAdding: false,
      isImage: true,
      isEditItem: false,
      isChangePass: false,
      deletingIndex: -1,
      deleteItem: {},
      isDeleting: false,
    };
  },

  methods: {
    async addProduct() {
      if (this.data.name.trim() == "") return this.e("Name is required");
      if (this.data.category_id == "") return this.e("Category is required");
      if (this.data.sub_category_id == "")
        return this.e("Sub Category_id is required");
      if (this.data.description.trim() == "")
        return this.e("Description is required");
      if (this.data.price == "") return this.e("Price is required");

      this.isAdding = true;
      this.data.images = this.imageList;

      if (this.data.images.length == 0) return this.e("Image is required");

      const res = await this.callApi("post", "/app/create_product", this.data);
      if (res.status == 200 || res.status == 201) {
        this.products.unshift(res.data);
        // console.log(this.products, 'yes')
        this.s("Product has been added successfully!");
        // this.addModal = false
        // this.data.name = ''
        // this.data.category_id = ''
        // this.data.sub_category_id = ''
        // this.data.description = ''
        // this.data.price = ''
        // this.$refs.uploads.clearFiles()
        // this.imageList = []
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

    async editProduct() {
      if (this.editData.name.trim() == "") return this.e("Name is required");
      if (this.editData.category_id == "")
        return this.e("Category is required");
      if (this.editData.sub_category_id == "")
        return this.e("Sub Category_id is required");
      if (this.editData.description.trim() == "")
        return this.e("Description is required");
      if (this.editData.price == "") return this.e("Price is required");
      this.editData.images = this.imageList;

      this.isAdding = true;

      const res = await this.callApi(
        "post",
        "/app/edit_product",
        this.editData
      );

      if (res.status === 200) {
        this.products[this.index] = this.editData;
        this.s("Product has been edited successfully!");
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

    async deleteProduct(item, index) {
      this.isDeleing = true;
      const res = await this.callApi("post", "/app/delete_product", item);
      if (res.status === 200) {
        this.products.splice(index, 1);
        this.i("Product has been deleted successfully!");
      } else {
        this.swr();
      }
      this.isDeleing = false;
    },

    async categorySearch(e) {
      const res = await this.callApi("get", `/app/get_category?str=${e}`);
      if (res.status === 200) {
        this.category = res.data;
      } else {
        this.swr();
      }
    },

    async subCategorySearch(e) {
      if (!this.data.category_id || this.data.category_id == "") {
        return this.e("Please selet your category!");
      }
      const res = await this.callApi(
        "get",
        `/app/search_subCategory?str=${e}&category_id=${this.data.category_id}`
      );
      if (res.status === 200) {
        this.subCategory = res.data;
      } else {
        this.swr();
      }
    },

    async categorySearchEdit(e) {
      // this.i('hello')
      const res = await this.callApi("get", `/app/get_category?str=${e}`);
      if (res.status === 200) {
        this.category = res.data;
      } else {
        this.swr();
      }
    },

    async subCategorySearchEdit(e) {
      if (!this.editData.category_id || this.data.editData == "") {
        return this.e("Please selet your category!");
      }
      const res = await this.callApi(
        "get",
        `/app/search_subCategory?str=${e}&category_id=${this.data.category_id}`
      );
      if (res.status === 200) {
        this.subCategory = res.data;
      } else {
        this.swr();
      }
    },

    showEditModal(item, index) {
      let obj = {
        id: item.id,
        name: item.name,
        category_id: item.category_id,
        sub_category_id: item.sub_category_id,
        description: item.description,

        price: item.price,
      };
      let ob = {
        id: item.category_id,
        name: item.category.name,
      };
      let ob1 = {
        id: item.sub_category_id,
        name: item.subcategory.name,
      };
      this.category.push(ob);
      this.subCategory.push(ob1);
      this.imageList = item.images;
      this.editData = obj;
      this.editModal = true;
      this.index = index;
      this.isEditItem = true;
    },

    closeEditModal() {
      this.isEditItem = false;
      this.editModal = false;
    },

    handleSuccess(res, file) {
      res = `/uploads/${res}`;
      if (this.isEditItem) {
        this.editData.image = res;
      }
      // this.imageList = res

      this.imageList.unshift({ image: res });
    },

    handleError(res, file) {
      console.log("res", res);
      this.$Notice.warning({
        title: "The file format is incorrect",
        desc: `${
          file.errors.file.length
            ? file.errors.file[0]
            : "Something went wrong!"
        }`,
      });
    },

    handleFormatError(file) {
      this.$Notice.warning({
        title: "The file format is incorrect",
        desc:
          "File format of " +
          file.name +
          " is incorrect, please select jpg or png.",
      });
    },

    handleMaxSize(file) {
      this.$Notice.warning({
        title: "Exceeding file size limit",
        desc: "File  " + file.name + " is too large, no more than 2M.",
      });
    },

    handleRemove(i) {
      this.imageList.splice(i, 1);
    },

    async deleteImage(isAdd) {
      let image;
      if (isAdd == 1) {
        image = this.data.image;
        this.data.image = "";
        this.$refs.uploads.clearFiles();
      } else {
        // // for editing
        // this.isImage = true
        // image = this.editData.iconImage
        // this.editData.iconImage = ''
        // this.$refs.editDataUploads.clearFiles()
      }

      const res = await this.callApi("post", "delete_image", {
        imageName: image,
      });
      if (res.status != 200) {
        this.data.image = image;
        this.swr();
      }
    },

    // async getAllCategory(){
    //     const res = await this.callApi('get', 'app/get_category')
    //     if(res.status==200){
    //         this.category = res.data

    //     }
    // },
  },

  async created() {
    this.token = window.Laravel.csrfToken;
    // this.getAllCategory()

    const res = await this.callApi("get", "/app/get_product");
    if (res.status === 200) {
      this.products = res.data;
    } else {
      this.swr();
    }
  },
};
</script>
<style scoped>
.demo-upload-list {
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
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.2);
  margin-right: 4px;
}
.demo-upload-list img {
  width: 100%;
  height: 100%;
}
.demo-upload-list-cover {
  display: none;
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(0, 0, 0, 0.6);
}
.demo-upload-list:hover .demo-upload-list-cover {
  display: block;
}
.demo-upload-list-cover i {
  color: #fff;
  font-size: 20px;
  cursor: pointer;
  margin: 0 2px;
}
</style>