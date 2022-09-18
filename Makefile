ifdef ENV
$(shell mv .env.($ENV) .env)
endif

do:
	docker-compose down
	docker rmi -f apiblog-app
	docker image prune -f -a
	docker-compose up -d

shell: do
	docker-compose --env-file $(ENVFILE) exec -it app bash
