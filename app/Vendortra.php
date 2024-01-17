<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Vendortra extends Model
{
    protected $fillable = [
        'vendor_id', 'total', 'paid', 'due'
    ];
}
