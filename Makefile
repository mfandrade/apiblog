ENV?=local
include .env.$(ENV)

.DEFAULT_GOAL := do

setup: .env.local .env.production
	@echo "INFO: Using .env.$(ENV)\n"
	@rm -f .env && cp -f .env.$(ENV) .env

do: setup
	docker-compose down
	@docker rmi -f apiblog-app 2>/dev/null
	@docker container prune -f >/dev/null
	@docker image prune -f -a >/dev/null
	docker-compose up -d

shell: .env
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

test-api: .env
	@php artisan route:clear
	@php artisan route:list
	@echo ----------------------------------------------------------------------
	links -dump $(APP_URL)/api/comments/1/post
	@echo ----------------------------------------------------------------------
	links -dump $(APP_URL)/api/posts/2/comments
