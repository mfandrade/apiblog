## How to test this API?

### 1. Bring it on

### 2. Check it's up and running

### 3. Run some HTTP requests against the endpoints

|What?  |How?   |Where? |
|---	|---	|---	|
|GET status it's working   	|`curl -sL $APP_URL/api`   	|-   	|
|GET all posts   	|`curl -sL $APP_URL/api/posts`   	|PostsController@index   	|
|GET first post   	|`curl -sL $APP_URL/api/posts/1`   	|PostsController@@show   	|
|POST create a new post   	|`curl -sL -d "{title='Title',body='Body'}" -H "Content-Type: application/json" -X POST $APP_URL/api/posts`   	|PostsController@store   	|
|PUT update a post   	|`curl -sL -d "{title='New Title',body='New Body'}" -H "Content-Type: application/json" -X PUT $APP_URL/api/posts/3`   	|PostsController@update   	|
|DELETE a post   	|`curl -sL -X DELETE $APP_URL/api/posts/3`   	|PostsController@destroy   	|
|GET post from a comment   	|`curl -sL $APP_URL/api/comments/1/post`   	|CommentsController@post   	|
|GET comments from a post   	|`curl -sL $APP_URL/api/posts/2/comments`   	|PostsController@comments   	|
