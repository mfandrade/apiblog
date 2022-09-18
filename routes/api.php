<?php
use App\Http\Controllers\CommentsController;
use App\Http\Controllers\PostsController;
use Illuminate\Support\Facades\Route;

Route::get('/', function() {
    return 'API is up and running...';
});
Route::apiResource('post', PostsController::class);
Route::apiResource('comment', CommentsController::class);
