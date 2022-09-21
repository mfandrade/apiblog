![apiblog](https://gitlab.com/uploads/-/system/project/avatar/39576926/apiblog.png?width=64)
# apiblog - A simple blog api for demo purposes

[![Deployed at AWS](https://img.shields.io/website-up-down-green-red/http/stack-ecsal-ad2c33tf7ncr-2140941407.us-east-1.elb.amazonaws.com.svg)]( http://stack-ecsal-ad2c33tf7ncr-2140941407.us-east-1.elb.amazonaws.com/api/posts/2/comments)


## What's this?

This is a repository for a sample application that implements the essence
of a blog in API format.

The main purpose here is it can be used as a demo app for DevOps, CI/CD
practices, automation and hosting on cloud servers.


## Please, tell me a bit more

The API consists in a MVC application (well, tecnically without
views) written in Laravel 9.  It represents the very core essence
of a blog with only two models: [Post](app/Models/Post.php) and
[Comment](app/Models/Comment).  A post can have many comments but a
comment belong to only one post.

There are a couple of sample data populated to those models via
migrations.  We can view those data [acessing this API](TESTING.md)
via REST.

###### KEYWORDS: **api, laravel, php, mvc, sqlite, mysql, devops, ci, ci/cd, gitlab-ci, aws, amazon, cloud, cloudcomputing, terraform, cloudformation, microservices**

----------
# tl;dr

```bash
$ git clone git@github.com:mfandrade/apiblog.git
$ cd apiblog
$ make
```

----------
# Requirements

* docker
* docker-compose
* A Docker HUB account
* make
* git
* An AWS account
* aws-cli


----------
Ⓜ<small><strong><a href="https://about.me/mfandrade">Marcelo F Andrade</strong></a> | <a href="LICENSE">LICENSE</a> | <a href="CONTRIBUTING">CONTRIBUTING</a></small>
