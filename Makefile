ENV?=local
include .env.$(ENV)

.DEFAULT_GOAL := run

setup: .env.local .env.production
	@echo "INFO: Using .env.$(ENV)\n"
	@rm -f .env && cp -f .env.$(ENV) .env

run: setup ##- Run app locally with Apache2 and MySQL backend.
	docker-compose down
	@docker rmi -f apiblog-app 2>/dev/null
	@docker rm -f apiblog-app-1 apiblog-sqlite 2>/dev/null
	@docker container prune -f >/dev/null
	@docker image prune -f -a >/dev/null
	docker-compose up -d

shell: .env ##- A Bash shell into the app container.
	docker-compose exec -it app bash

seconds:=0 # dummy way to wait until mysql be up and running
test-db: .env
	@sleep $(seconds)
	docker-compose exec -it $(DB_HOST) \
	mysql -u$(DB_USERNAME) -p $(DB_DATABASE)

SQL?=SHOW TABLES;
test-sql: .env
	@sleep $(seconds)
	docker-compose exec $(DB_HOST) \
	mysql -u$(DB_USERNAME) -p$(DB_PASSWORD) $(DB_DATABASE) \
		-e '$(SQL)' 2>/dev/null

dump: .env
	@sleep $(seconds)
	docker-compose exec -it $(DB_HOST) mysqldump -u$(DB_USERNAME) -p $(DB_DATABASE) | tee mysqldump.sql

test-api: .env ##- Simple HTTP get requests for posts and comments.
	@php artisan route:clear
	@php artisan route:list
	@echo ----------------------------------------------------------------------
	curl -sL $(APP_URL)/api/comments/1/post
	@echo ----------------------------------------------------------------------
	curl -sL $(APP_URL)/api/posts/2/comments

publish: run ##- Publish mfandrade/apiblog:latest to Docker HUB.
	git push github main
	git push gitlab main
	docker push mfandrade/apiblog:latest

help: ##- This message.
	@echo 'USAGE: make <TARGET> [VARNAME=value]'
	@echo
	@echo 'TARGET can be:'
	@sed -e '/#\{2\}-/!d; s/\\$$//; s/:[^#\t]*/\t- /; s/#\{2\}- *//' $(MAKEFILE_LIST)
