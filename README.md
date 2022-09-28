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
$ make run
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
* [curl](https://curl.se/)
* [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* [sqlite3](https://www.sqlite.org/download.html)
* [An AWS account](https://aws.amazon.com/resources/create-account/)
* [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

# Project structure

```
apiblog/
├── src/                     - root dir of the Laravel application
│   ├── .env.local           - file with env vars for local execution
│   └── .env.production      - file with env vars for production execution
├── files /                  - miscelaneous files mainly used in Dockerfile
│   ├── cloudformation.yaml  - one-tier infrastructure designed to run on AWS
│   └── laravel.conf         - simple vhost configuration to serve the app in Apache2
├── Dockerfile               - Dockerfile to containerize the Laravel application
├── Makefile                 - swiss-knife for running, testing and deploying the app
├── docker-compose.yaml      - docker-compose file for local test in two-tier mode
├── .github/workflows/       - artifacts for CI/CD via GitHub Actions
└── .gitlab-ci.yaml          - artifact for CI/CD via Gitlab-CI
```

## How to test this API?

### 1. Bring it on

### 2. Check it's up and running

### 3. Run some HTTP requests against the endpoints

|What?  |How?   |Where? |
|---	|---	|---	|
|GET status it's working   	|`curl -sL $APP_URL/api`   	|-   	|
|GET all posts   	|`curl -sL $APP_URL/api/posts`   	|PostsController@index   	|
|GET first post   	|`curl -sL $APP_URL/api/posts/1`   	|PostsController@show   	|
|POST create a new post   	|`curl -sL -X POST -d "{title='Title',body='Body'}" -H "Content-Type: application/json" $APP_URL/api/posts`   	|PostsController@store   	|
|PUT update a post   	|`curl -sL -X PUT -d "{title='New Title'}" -H "Content-Type: application/json" $APP_URL/api/posts/3`   	|PostsController@update   	|
|DELETE a post   	|`curl -sL -X DELETE $APP_URL/api/posts/3`   	|PostsController@destroy   	|
|GET post from a comment   	|`curl -sL $APP_URL/api/comments/1/post`   	|CommentsController@post   	|
|GET comments from a post   	|`curl -sL $APP_URL/api/posts/2/comments`   	|PostsController@comments   	|

----------
&#x24C2; <small><strong><a href="https://about.me/mfandrade">Marcelo F Andrade</strong></a> | <a href="CONTRIBUTING">CONTRIBUTING</a> | <a href="LICENSE">LICENSE</a></small>
