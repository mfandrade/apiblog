ENV?=local
include .env.$(ENV)

do: setup
	docker-compose down -v
	docker rmi -f apiblog-app
	docker image prune -f -a
	docker-compose up -d

shell: .env
	docker-compose exec -it app bash

test-db: .env
	docker-compose exec -it $(DB_HOST) mysql -u$(DB_USERNAME) -p $(DB_DATABASE)

dump: .env
	docker-compose exec -it $(DB_HOST) mysqldump -u$(DB_USERNAME) -p $(DB_DATABASE) | tee mysqldump.sql

test-api: .env
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

