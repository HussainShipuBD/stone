<?php

namespace App\Http\Controllers;

use App\Category;
use App\SubCategory;
use App\Product;
use App\User;
use App\ProductImage;
use App\Addcard;
use App\Order;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;

class MainController extends Controller
{
    // Add category
    public function addCategory(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|string|max:255'
        ]);

        $user = Category::create([
            'name' => $request->name
        ]);

        return $user;
    }

    // Get category
    public function getCategory(Request $request)
    {
        $str = isset($request->str) ? $request->str : '';
        // $str = $data['str'];
        $q = Category::orderBy('id', 'desc');
        if ($str) {
            $q->where('name', 'like', "%$str%");
        }
        return $q->get();
    }

    // Edit Category
    public function editCategory(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|string|max:255'
        ]);

        $data = [
            'name' => $request->name
        ];

        $user = Category::where('id', $request->id)->update($data);
        return $user;
    }

    // Delete Category
    public function deleteCategory(Request $request)
    {
        $this->validate($request, [
            'id' => 'required'
        ]);

        return Category::where('id', $request->id)->delete();
    }

    // Add sub category
    public function addSubCategory(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|string|max:255'
        ]);

        $user = SubCategory::create([
            'name' => $request->name,
            'category_id' => $request->category_id
        ]);

        return $user;
    }

    // Edit Sub Category
    public function editSubCategory(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|string|max:255'
        ]);

        $data = [
            'name' => $request->name
        ];

        $user = SubCategory::where('id', $request->id)->update($data);
        return $user;
    }

    // Delete Sub Category
    public function deleteSubCategory(Request $request)
    {
        $this->validate($request, [
            'id' => 'required'
        ]);

        return SubCategory::where('id', $request->id)->delete();
    }

    // Get Sub category
    public function getSubCategory($key)
    {
        return SubCategory::orderBy('id', 'desc')
            ->where('category_id', $key)
            ->get();
    }

    // Get Sub category
    public function getCategorySubPage($key)
    {
        return Category::where('id', $key)
            ->first();
    }

    // Search sub category
    public function searchSubCategory(Request $request)
    {
        $str = isset($request->str) ? $request->str : '';
        $key = isset($request->category_id) ? $request->category_id : '';
        // $str = $data['str'];
        $q = SubCategory::orderBy('id', 'desc');
        if ($str) {
            $q->where('name', 'like', "%$str%");
        }
        return $q->where('category_id', $key)->get();
    }

    // Add product
    public function createProduct(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|string|max:255',
            'category_id' => 'required',
            'sub_category_id' => 'required',
            'description' => 'required|string',
            'price' => 'required'
        ]);

        $data = $request->all();
        $link = $data['images'];
        unset($data['images']);
        // return $link;
        $product =  Product::create($data);

        $photo = [];
        if (sizeof($link) > 0) {
            foreach ($link as  $value) {
                $ob = [];
                $ob['product_id'] = $product->id;
                $ob['image'] = $value['image'];
                array_push($photo, $ob);
            }
            ProductImage::insert($photo);
        }

        // return Product::with('images')
        // ->with('category')
        // ->with('subcategory')
        // ->where('id' , $product['id'])
        // ->orderBy('id', 'desc')
        // ->get();


        return $data;
    }

    // Edit Category
    public function editProduct(Request $request)
    {
        $this->validate($request, [
            'name' => 'required|string|max:255',
            'category_id' => 'required',
            'sub_category_id' => 'required',
            'description' => 'required|string',
            'price' => 'required'
        ]);

        $data = $request->all();
        $link = $data['images'];
        unset($data['images']);
        unset($data['image']);

        Product::where('id',  $data['id'])->update($data);
        ProductImage::where('product_id', $data['id'])->delete();

        $photo = [];
        if (sizeof($link) > 0) {
            foreach ($link as  $value) {
                $ob = [];
                $ob['product_id'] = $data['id'];
                $ob['image'] = $value['image'];
                array_push($photo, $ob);
            }
            ProductImage::insert($photo);
        }

        return Product::where('id', $data['id'])
            ->with('images')
            ->with('category')
            ->with('subcategory')
            ->first();
    }

    // Get product
    public function getProduct()
    {
        return Product::with('images')
            ->with('category')
            ->with('subcategory')
            ->orderBy('id', 'desc')
            ->get();
    }

    // Delete product
    public function deleteProduct(Request $request)
    {
        $this->validate($request, [
            'id' => 'required'
        ]);

        return Product::where('id', $request->id)->delete();
    }

    // Get page category
    public function getMenus()
    {
        return Category::with('subcategory')
            ->orderBy('id', 'desc')
            ->get();
    }

    // Get page product
    public function getPageProduct($key)
    {
        return Product::with('images')
            ->with('category')
            ->with('subcategory')
            ->where('sub_category_id', $key)
            ->orderBy('id', 'desc')
            ->get();
        // return Product::orderBy('id', 'desc')->where('sub_category_id', $key)->get();
    }

    // Get page product
    public function getProductDetails($key)
    {
        return Product::with('images')
            // ->with('category')
            // ->with('subcategory')
            ->where('id', $key)
            ->first();
        // return Product::orderBy('id', 'desc')->where('sub_category_id', $key)->get();
    }

    // Add cart
    public function addCart(Request $request)
    {
        $this->validate($request, [
            'user_id' => 'required',
            'product_id' => 'required',
            'quantity' => 'required',
        ]);

        $user = Addcard::create([
            'user_id' => $request->user_id,
            'quantity' => $request->quantity,
            'product_id' => $request->product_id
        ]);

        return $user;
    }

    // Get Add product
    public function getAddGart()
    {

        return Addcard::with('product.images')
            ->where('user_id', Auth::id())
            ->first();
    }

    // Add order
    public function addOrder(Request $request)
    {
        $this->validate($request, [
            'product_id' => 'required',
            'quantity' => 'required',
            'price' => 'required',
            'subTotal' => 'required',
            'delivery_type' => 'required',
            'firstName' => 'required',
            'lastName' => 'required',
            'address' => 'required',
            'phone' => 'required',
            'address' => 'required',
            'delivery_type' => 'required',
            'paymentType' => 'required',
        ]);


        $user = Order::create([
            'product_id' => $request->product_id,
            'user_id' => $request->user_id,
            'quantity' => $request->quantity,
            'price' => $request->price,
            'subTotal' => $request->subTotal,
            'delivery_type' => $request->delivery_type,
            'delivery_status' => $request->delivery_status,
            'delivery_cost' => $request->delivery_cost,
            'orderStatus' => 'pending',
            'firstName' => $request->firstName,
            'lastName' => $request->lastName,
            'address' => $request->address,
            'phone' => $request->phone,
            'paymentType' => $request->paymentType,
        ]);

        Addcard::where('user_id', $request->user_id)->delete();

        return $user;
    }

    // Get Subcategory with product
    public function getSubBategoryProduct()
    {
        return SubCategory::with('product.images')
            ->get();
    }

    // Get order
    public function getOrder()
    {
        return Order::with('product.images')
            ->get();
    }

    // Get page order
    public function getPageOrder()
    {
        $user = Auth::user();
        $userId = $user->id;
        // return $userId;
        return Order::with('product.images')
            ->where('user_id', $userId)
            ->first();
    }

    // Update order status
    public function updateOrderStatus(Request $request)
    {
        $this->validate($request, [
            'orderStatus' => 'required|string|max:255'
        ]);

        $data = [
            'orderStatus' => $request->orderStatus,
            'reason' => $request->reason
        ];

        $user = Order::where('id', $request->id)->update($data);

        if ($data['orderStatus'] == 'reject' && isset($request->reason)) {
            $uid = Order::where('id', $request->id)
                ->first();

            $user = User::where('id', $uid->user_id)->first();

            $smstext = urlencode($request->reason);
            $client = new \GuzzleHttp\Client();
            $request = (string) $client->get("https://tpsms.xyz/sms/api?action=send-sms&api_key=cGF0aG9yZXJqb2dvdGg6cGF0aG9yZXJqb2dvdGg=&to=88$user->phone&from=8804445620750&sms=$smstext")->getBody();
        }

        return $user;
    }
    // Update order delivery cost
    public function updateOrderDeliveryCost(Request $request)
    {
        $this->validate($request, [
            'delivery_cost' => 'required'
        ]);

        $data = [
            'delivery_cost' => $request->delivery_cost
        ];

        $user = Order::where('id', $request->id)->update($data);
        return $user;
    }

    // Update qty numbae
    public function updateQty(Request $request)
    {
        $this->validate($request, [
            'quantity' => 'required'
        ]);

        $data = [
            'quantity' => abs($request->quantity)
        ];

        $user = Addcard::where('id', $request->id)->update($data);
        return $user;
    }

    // Get Transaction
    public function getTransaction(Request $request)
    {
        $orderStatus =  'complate';
        $str = isset($request->str) ? $request->str : '';
        // $str = $data['str'];
        $q = Order::where('orderStatus', '=', $orderStatus)->with('product.images');
        if ($str) {
            // return 'shipu';
            $q->where('firstName', 'like', "%$str%");
            $q->orWhere('lastName', 'like', "%$str%");
            $q->orWhere('phone', 'like', "%$str%");
        }
        return $q->orderBy('id', 'desc')->get();
    }
}
