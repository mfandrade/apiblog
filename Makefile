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

test-api:
	links -dump laravel.app:8000/api/posts | less
