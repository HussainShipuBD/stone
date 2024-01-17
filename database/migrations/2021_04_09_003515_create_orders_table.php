<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOrdersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->integer('user_id');
            $table->integer('product_id');
            $table->integer('quantity');
            $table->string('delivery_type')->default('pending');
            $table->string('delivery_status')->nullable();
            $table->integer('delivery_cost')->nullable();
            $table->string('orderStatus')->default('pending');
            $table->string('firstName');
            $table->string('lastName');
            $table->string('address');
            $table->string('phone');
            $table->string('paymentType');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('orders');
    }
}
