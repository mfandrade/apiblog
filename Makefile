ifndef APP_ENV
ENVFILE=.env
else
ENVFILE=.env.$(APP_ENV)
endif

do:
	docker-compose down
	docker rmi -f apiblog-app
	docker image prune -f -a
	docker-compose --env-file $(ENVFILE) up -d

shell: do
	docker-compose exec -it app bash

build:
	docker-compose exec app pwd && \
	echo --- && \
	docker-compose exec app /app

