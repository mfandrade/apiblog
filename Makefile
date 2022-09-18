ENV?=local
include .env.$(ENV)

do: .env.local .env.production
	ln -sf .env.$(ENV) .env
	docker-compose down
	docker rmi -f apiblog-app
	docker image prune -f -a
	docker-compose up -d

shell:
	docker-compose exec -it app bash

test-db: .env
	docker-compose exec -it $(DB_HOST) mysql -u$(DB_USERNAME) -p $(DB_DATABASE)

mysqldump: .env
	docker-compose exec -it $(DB_HOST) mysqldump -u$(DB_USERNAME) -p $(DB_DATABASE) | tee mysqldump.sql

test-api:
	php artisan route:clear
	php artisan route:list
	#curl -sL $(APP_URL)/api | head 
	#curl -sL $(APP_URL)/api/posts | head 
	#curl -sL $(APP_URL)/api/posts/1 | head 
	links -dump $(APP_URL)/api | head
	links -dump $(APP_URL)/api/posts | head
	links -dump $(APP_URL)/api/posts/1 | head
