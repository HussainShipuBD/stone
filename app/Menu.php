<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Menu extends Model
{
    // protected $fillable = [
    //     'name'
    // ];
    public function category(){
        return $this->hasMany('App\Category')->where('isDeleted',0);
    }
    public function subcategory(){
        return $this->hasMany('App\Subcategory')->where('isDeleted',0);
    }
    // public function products(){
    //     return $this->hasMany('App\Product')->where('isDeleted',0);
    // }

}
