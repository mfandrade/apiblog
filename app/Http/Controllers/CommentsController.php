<?php

namespace App\Http\Controllers;

use App\Http\Requests\CommentRequest;
use App\Models\Comment;
use App\Models\Post;

class CommentsController extends Controller
{
    public function index()
    {
        return Comment::all();
    }

    public function store(CommentRequest $request)
    {
        return Comment::create($request->all());
    }

    public function show(Comment $comment)
    {
        return Comment::findOrFail($comment->id);
    }

    public function update(CommentRequest $request, Comment $comment)
    {
        $item = Comment::findOrFail($comment->id);
        $item->fill($request->all());
        $item->save();

        return $item;
    }

    public function destroy(Comment $comment)
    {
        $item = Comment::findOrFail($comment->id);
        $item->delete();
    }

    public function post(Comment $comment)
    {
        return $comment->post_id;
    }
}
