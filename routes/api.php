<?php
use App\Http\Controllers\CommentController;
use App\Http\Controllers\PostController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::apiResource('post', PostController::class);
Route::apiResource('comment', CommentController::class);
