<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    protected $fillable = [
        'user_id','product_id', 'quantity', 'price', 'subTotal', 'delivery_type', '	delivery_status', 'delivery_cost', 'orderStatus', 'firstName', 'lastName', 'address', 'phone', 'paymentType'
    ];

    public function product(){
        return $this->belongsTo(Product::class, 'product_id', 'id');
    }
}
