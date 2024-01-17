<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Driver extends Model
{
    protected $fillable = [
        'name', 'image', 'nidFont', 'nidBack','license','address', 'phone', 'engineNo', 'chasisNo'
    ];
}
