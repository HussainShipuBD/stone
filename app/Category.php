<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    protected $fillable = [
        'name'
    ];

    // public function subcategory(){
    //     return $this->hasMany('App\Subcategory')->where('isDeleted',0);
    // }

    public function subcategory()
    {
        return $this->hasMany(SubCategory::class);
    }
}
