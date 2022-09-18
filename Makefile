ifndef APP_ENV
ENVFILE=.env
else
ENVFILE=.env.$(APP_ENV)
endif

do:
	@echo "INFO: Using $(ENVFILE)\n"
	docker-compose --env-file $(ENVFILE) down
	docker rmi -f apiblog-app
	docker image prune -f -a
	docker-compose --env-file $(ENVFILE) up -d

shell: do
	docker-compose --env-file $(ENVFILE) exec -it app bash
