<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    use Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'firstName', 'lastName','image', 'email','phone', 'password', 'address','userType', 'email_verified_at', 'resetToken', 'accountActivationCode'
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */

    // public function forums(){
    //     return $this->hasMany('App\ForumPost', 'user_id')->select('id','user_id');
    //  }
    // protected $hidden = [
    //     'password', 'remember_token',
    // ];
  
}
