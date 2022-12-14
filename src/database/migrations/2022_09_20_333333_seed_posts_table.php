<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

return new class extends Migration
{
  public function up()
  {
    DB::table('posts')->insert([
      [
        'id'         => 1,
        'title'      => 'Hello API World!',
        'body'       => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.  Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.  Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        'created_at' => Carbon::now(),
        'updated_at' => Carbon::now()
      ], [
        'id'         => 2,
        'title'      => 'Soneto de Fidelidade',
        'body'       => '<p>De tudo ao meu amor serei atento <br>Antes; e com tal zelo, e sempre, e tanto <br>Que mesmo em face do maior encanto <br>Dele se encante mais meu pensamento</p><p>Quero vivê-lo em cada vão momento <br>E em seu louvor hei de espalhar meu canto <br>E rir me riso, e derramar meu pranto <br>Ao seu pesar ou seu contentamento</p><p>E assim quando mais tarde me procure<br>quem sabe a morte, angústia de quem vive <br>quem sabe a solidão, fim de quem ama</p><p>Eu possa me dizer do amor (que tive) <br>que não seja imortal, posto que é chama <br>mas que seja infinito enquanto dure.</p>',
        'created_at' => Carbon::now(),
        'updated_at' => Carbon::now()
      ]
    ]);
  }
  public function down()
  {
    DB::table('posts')->delete();
  }
};
