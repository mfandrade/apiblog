<?php

namespace App\Http\Controllers;

use App\Http\Requests\PostRequest;
use App\Models\Post;

class PostsController extends Controller
{
    public function index()
    {
        return Post::all();
    }

    public function show(Post $post)
    {
        return Post::findOrFail($post->id);
    }

    public function destroy(Post $post)
    {
        $item = Post::findOrFail($post->id);
        $item->delete();
    }

    public function store(PostRequest $request)
    {
        return Post::create($request->all());
    }

    public function update(PostRequest $request, Post $post)
    {
        $item = Post::findOrFail($post->id);
        $item->fill($request->all());
        $item->save();

        return $item;
    }
}
