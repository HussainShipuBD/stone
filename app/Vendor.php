<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Vendor extends Model
{
    protected $fillable = [
        'name', 'image' ,'nidFont','nidBack', 'tradeLicense', 'address', 'phone', 'agreement', 'bankingAccount'
    ];
}
