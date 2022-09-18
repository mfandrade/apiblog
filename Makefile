ENV?=local

do: .env.local .env.production
	ln -sf .env.$(ENV) .env
	docker-compose down
	docker rmi -f apiblog-app
	docker image prune -f -a
	docker-compose up -d

shell: do
	docker-compose exec -it app bash
