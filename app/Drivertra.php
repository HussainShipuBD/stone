<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Drivertra extends Model
{
    protected $fillable = [
        'driver_id', 'total', 'paid', 'due'
    ];

    // public function driver(){
    //     return $this->belongsTo(Driver::class, 'driver_id', 'id');
    // }
}
