<?php
// use App\Http\Middleware\AdminCheck;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

// Route::prefix('app')->middleware([AdminCheck::class])->group(function(){

//     // Route::get('app/all_user_pagi', 'UserController@all_user_pagi');
// });

// //Category
// Route::get('all_category', 'CategoryController@all_category');
// Route::get('getCategorywithLimit', 'CategoryController@getCategorywithLimit');
Route::get('/', 'UserController@index');
Route::get('/login', 'UserController@goLogin');
Route::post('/app/registration', 'UserController@registration');
Route::post('/app/verification', 'UserController@verification');
Route::post('/app/send_code_again', 'UserController@sendCodeAgain');
Route::post('/app/activateAccount', 'UserController@activateAccount');

Route::get('/app/getsms', 'UserController@testSms');

Route::post('/upload', 'UserController@upload');
Route::post('/delete_image', 'UserController@deleteImage');

// Pages routes
Route::get('/app/menus','MainController@getMenus');
Route::get('/app/getPage_product/{key}','MainController@getPageProduct');
Route::get('/app/get_product_details/{key}','MainController@getProductDetails');
Route::get('/app/get_subBategory_product','MainController@getSubBategoryProduct');

// Add cart
Route::post('/app/add_cart', 'MainController@addCart');
Route::get('/app/get_add_cart', 'MainController@getAddGart');

// Order
Route::post('/app/add_order', 'MainController@addOrder');



// Admin routes
// Admin
Route::post('/app/create_admin', 'UserController@createAdmin');
Route::get('/app/get_admin', 'UserController@getAdmin');
Route::get('/app/get_user', 'UserController@getUser');
Route::post('/app/edit_admin', 'UserController@editAdmin');
Route::post('/app/delete_admin', 'UserController@deleteAdmin');

// Driver
Route::post('/app/create_driver', 'UserController@createDriver');
Route::get('/app/get_driver', 'UserController@getDriver');
Route::post('/app/edit_driver', 'UserController@editDriver');
Route::post('app/delete_driver', 'UserController@deleteDriver');
Route::post('/app/add_driverTra', 'UserController@addDriverTra');
Route::get('/app/get_driverTra/{key}', 'UserController@getDriverTra');
Route::get('/app/get_driverPro/{key}', 'UserController@getDriverPro');

// Vendor
Route::post('app/create_vendor', 'UserController@createVendor');
Route::get('app/get_vendor', 'UserController@getVendor');
Route::post('app/edit_vendor', 'UserController@editVendor');
Route::post('app/delete_vendor', 'UserController@deleteVendor');
Route::post('/app/add_vendorTra', 'UserController@addVendorTra');
Route::get('/app/get_vendorTra/{key}', 'UserController@getVendorTra');
Route::get('/app/get_vendorPro/{key}', 'UserController@getVendorPro');

// Category
Route::post('/app/add_category', 'MainController@addCategory');
Route::post('/app/edit_category', 'MainController@editCategory');
Route::post('/app/delete_category', 'MainController@deleteCategory');
Route::post('/app/add_subCategory', 'MainController@addSubCategory');
Route::get('/app/get_category', 'MainController@getCategory');
Route::get('/app/get_SubCategory/{key}', 'MainController@getSubCategory');
Route::get('/app/search_subCategory', 'MainController@searchSubCategory');
Route::post('/app/edit_sub_category', 'MainController@editSubCategory');
Route::post('/app/delete_sub_category', 'MainController@deleteSubCategory');
Route::get('/app/get_category_subPage/{key}', 'MainController@getCategorySubPage');

// Product
Route::post('/app/add_category', 'MainController@addCategory');
Route::post('/app/create_product', 'MainController@createProduct');
Route::get('/app/get_product', 'MainController@getProduct');
Route::post('/app/edit_product', 'MainController@editProduct');
Route::post('/app/delete_product', 'MainController@deleteProduct');

// Order
Route::get('/app/get_order', 'MainController@getOrder');
Route::get('/app/get_page_order', 'MainController@getPageOrder');
Route::post('/app/update_order_status', 'MainController@updateOrderStatus');
Route::post('/app/update_order_delivery_cost', 'MainController@updateOrderDeliveryCost');
Route::post('/app/update_qty', 'MainController@updateQty');
Route::get('/app/get_transaction', 'MainController@getTransaction');

Route::post('/app/login', 'UserController@login');
Route::get('/logout', 'UserController@logout');


Route::any('{slug}', 'UserController@home')->where('slug', '([A-z\d\-\/_.]+)?');



