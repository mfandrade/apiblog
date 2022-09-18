do:
	docker-compose down
	docker rmi -f apiblog-app
	docker image prune -f -a
	docker-compose up -d

shell: do
	docker-compose exec -it app bash

build:
	docker-compose exec app pwd && \
	echo --- && \
	docker-compose exec app /app

