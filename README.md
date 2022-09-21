![apiblog](https://gitlab.com/uploads/-/system/project/avatar/39576926/apiblog.png?width=96)
# apiblog - a simple blog API for demo purposes.

[![Deployed at AWS](https://img.shields.io/website-up-down-green-red/http/stack-ecsal-ad2c33tf7ncr-2140941407.us-east-1.elb.amazonaws.com.svg)]( http://stack-ecsal-ad2c33tf7ncr-2140941407.us-east-1.elb.amazonaws.com/api/posts/2/comments)


This is a repository for a sample application that implements the essence
of a blog in API format.

The main purpose here is it can be used as a demo app for DevOps, CI/CD
practices, automation and hosting on cloud servers.

###### KEYWORDS: **api, laravel, php, mvc, sqlite, mysql, devops, ci, ci/cd, gitlab-ci, aws, amazon, cloud, cloudcomputing, terraform, cloudformation, microservices**

# tl;dr

```bash
$ git clone git@github.com:mfandrade/apiblog.git
$ cd apiblog
$ make
```
----------

## Tell me a bit more

The API consists in a MVC application (well, tecnically without
views) written in Laravel 9.  It represents the very core essence
of a blog with only two models: [Post](app/Models/Post.php) and
[Comment](app/Models/Comment.php).  A post can have many comments but
a comment belong to only one post.

There are a couple of sample data populated to those models via
migrations.  We can view those data [acessing this API](TESTING.md)
via REST.

# Requirements

* [docker](https://docs.docker.com/desktop/install/linux-install/)
* [docker-compose](https://github.com/docker/compose/releases)
* [A Docker HUB account](https://hub.docker.com/signup)
* [make](https://www.gnu.org/software/make/)
* [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* [sqlite3](https://www.sqlite.org/download.html)
* [An AWS account](https://aws.amazon.com/resources/create-account/)
* [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

# Project structure

```
apiblog/
├── src/                     -
│   ├── .env.local           -
│   └── .env.production      -
├── Dockerfile               -
├── Makefile                 -
├── aws-cloudformation.yaml  -
├── docker-compose.yaml      -
├── script.sql               -
├── .github/workflows/       -
└── .gitlab-ci.yaml          -
```

----------
&#x24C2; <small><strong><a href="https://about.me/mfandrade">Marcelo F Andrade</strong></a> | <a href="CONTRIBUTING">CONTRIBUTING</a> | <a href="LICENSE">LICENSE</a> | <a href="TESTING.md">TESTING</a></small>
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
