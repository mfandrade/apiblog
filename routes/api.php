<?php
use App\Http\Controllers\CommentsController;
use App\Http\Controllers\PostsController;
use Illuminate\Support\Facades\Route;

Route::get('/', function() {
    return 'API is up and running...';
});
Route::apiResource('posts', PostsController::class)
  ->except(['index']);

Route::get('/posts/index', function() {
  return 'blablabla';
})->name('posts.index');

Route::apiResource('comments', CommentsController::class);
