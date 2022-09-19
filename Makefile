ENV?=local
include .env.$(ENV)

do: setup
	docker-compose down -v
	docker rmi -f apiblog-app
	docker image prune -f -a
	docker-compose up -d

shell: .env
	docker-compose exec -it app bash

wait=5 # until mysql be up and running
test-db: .env
	@sleep $(wait) && \
	docker-compose exec -it $(DB_HOST) \
	mysql -u$(DB_USERNAME) -p $(DB_DATABASE)

SQL?=SHOW TABLES;
test-sql: .env
	@sleep $(wait) && \
	docker-compose exec $(DB_HOST) \
	mysql -u$(DB_USERNAME) -p$(DB_PASSWORD) $(DB_DATABASE) \
		-e '$(SQL)' 2>/dev/null

dump: .env
	@sleep $(wait) && \
	docker-compose exec -it $(DB_HOST) mysqldump -u$(DB_USERNAME) -p $(DB_DATABASE) | tee mysqldump.sql

test-api: .env
	@sleep $(wait)
	php artisan route:clear
	php artisan route:list
	#curl -sL $(APP_URL)/api | head 
	#curl -sL $(APP_URL)/api/posts | head 
	#curl -sL $(APP_URL)/api/posts/1 | head 
	links -dump $(APP_URL)/api | head
	links -dump $(APP_URL)/api/posts | head
	links -dump $(APP_URL)/api/posts/1 | head

setup: .env.local .env.production
	rm .env && cp -f .env.$(ENV) .env

