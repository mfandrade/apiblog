# -----------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# <mfandrade@gmail.com> wrote this file. As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer in return.   Marcelo F Andrade
# -----------------------------------------------------------------------------

ENV?=local
include .env.$(ENV)

.DEFAULT_GOAL := run

setup: .env.local .env.production
	@echo "INFO: Using .env.$(ENV)\n"
	@rm -f .env && cp -f .env.$(ENV) .env

cleanup: docker-compose.yaml
	docker-compose down
	@docker rm -f apiblog-sqlite apiblog-app-1 2>/dev/null
	@docker container prune -f >/dev/null
	@docker image prune -f -a >/dev/null

run: setup cleanup ##- Runs the app locally with Apache2 and MySQL backend.
	docker-compose up -d

shell: .env ##- A Bash shell into the app container.
	docker-compose exec -it app bash

seconds:=0 # dummy way to wait until mysql be up and running
test-db: .env ##- Asks for the user password and gets to the database client.
	@sleep $(seconds)
	docker-compose exec -it $(DB_HOST) \
	mysql -u$(DB_USERNAME) -p $(DB_DATABASE)

SQL?=SHOW TABLES;
test-sql: .env ##- Runs SQL command in the database [SQL='SELECT ...']
	@sleep $(seconds)
	docker-compose exec $(DB_HOST) \
	mysql -u$(DB_USERNAME) -p$(DB_PASSWORD) $(DB_DATABASE) \
		-e '$(SQL)' 2>/dev/null

db-dump: .env ##- Dumps database content in SQL format to stdout.
	@sleep $(seconds)
	docker-compose exec -it $(DB_HOST) mysqldump -u$(DB_USERNAME) -p $(DB_DATABASE) | tee database.dump.sql

test-api: .env ##- Simple HTTP get requests for posts and comments.
	@php artisan route:clear
	@php artisan route:list
	@echo ----------------------------------------------------------------------
	curl -sL $(APP_URL)/api/comments/1/post
	@echo ----------------------------------------------------------------------
	curl -sL $(APP_URL)/api/posts/2/comments

publish: run ##- Publishes mfandrade/apiblog:latest to Docker HUB (must be logged in previously).
	git push github main && git push gitlab main
	docker push mfandrade/apiblog:latest

help: ##- This message.
	@echo 'USAGE: make <TARGET> [VARNAME=value]'
	@echo
	@echo 'TARGET can be:'
	@sed -e '/#\{2\}-/!d; s/\\$$//; s/:[^#\t]*/\t- /; s/#\{2\}- *//' $(MAKEFILE_LIST)
