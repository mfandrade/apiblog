<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up()
    {
      DB::table('comments')->insert( 
        [ 'post_id' => 2,
          'text' => 'Muito lindo esse soneto!  Vinícius de Moraes é maravilhoso!']
      );
    }

    public function down()
    {
      DB::table('comments')->delete();
    }
};
