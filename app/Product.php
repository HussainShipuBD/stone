<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $fillable = [
        'name', 'category_id','sub_category_id','description', 'price'
    ];

    public function images(){
        return $this->hasMany(ProductImage::class, 'product_id');
    }
    public function category(){
        return $this->belongsTo(Category::class, 'category_id', 'id');
    }
    public function subcategory(){
        return $this->belongsTo(SubCategory::class, 'sub_category_id');
    }
}
