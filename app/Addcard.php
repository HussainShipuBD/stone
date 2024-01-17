<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Addcard extends Model
{
    protected $fillable = [
        'user_id', 'product_id', 'quantity'
    ];

    public function product(){
        return $this->belongsTo(Product::class, 'product_id');
    }

    // public function images(){
    //     return $this->hasMany(ProductImage::class, 'product_id', 'id');
    // }
}
