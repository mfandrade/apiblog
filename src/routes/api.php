<?php
use App\Http\Controllers\CommentsController;
use App\Http\Controllers\PostsController;
use Illuminate\Support\Facades\Route;

Route::get('/', function() {
    return 'API is up and running...';
});
Route::apiResource('posts', PostsController::class);
Route::apiResource('comments', CommentsController::class);
Route::get('posts/{post}/comments', [PostsController::class, 'comments']);
Route::get('comments/{comment}/post', [CommentsController::class, 'post']);
