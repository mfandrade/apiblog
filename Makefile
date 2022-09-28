# =============================================================================
# "THE BEER-WARE LICENSE" (Revision 42):
# <mfandrade@gmail.com> wrote this file. As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer in return.   Marcelo F Andrade
# =============================================================================

# The root of the application project
SRC := src/

# A kitten dies for every change you make below this line. =^.^=
# -----------------------------------------------------------------------------
.DEFAULT_GOAL := help

ifeq ($(wildcard $(SRC).env),)
# default env
APP_ENV:=local
else
# include file if it exists
include $(SRC).env
endif

DB_CONNECTION?=mysql

$(info INFO: $(APP_ENV) / $(DB_CONNECTION))

$(SRC).env: $(SRC).env.local $(SRC).env.production
	cp -f $(SRC).env.$(APP_ENV) $(SRC).env

clean: $(SRC).env docker-compose.yaml ##- Removes generated containers.
	docker rm --force apiblog-sqlite 2>/dev/null
	docker-compose --env-file $(SRC).env down 2>/dev/null

fixperms:
	chgrp -R www-data $(SRC)
	find $(SRC)bootstrap/cache/ $(SRC)storage/ -type d -exec chmod 775 {} \+
	find $(SRC) -type d -exec chmod g+s {} \+

run: $(SRC).env docker-compose.yaml fixperms ##- Runs the app in background.
	if [ "$(DB_CONNECTION)" = "sqlite" ] ; \
	then \
		touch $(SRC)database/database.sqlite ; \
		docker build . --tag mfandrade/apiblog:sqlite ; \
		docker run --env-file $(SRC).env --name apiblog-sqlite --detach \
			--publish 80:80 \
			--volume $(CURDIR)/$(SRC)database:/srv/laravel/database \
			mfandrade/apiblog:sqlite ; \
		docker exec --env-file $(SRC).env apiblog-sqlite bash -c \
			'php artisan migrate:fresh; php artisan config:cache' ; \
	elif [ "$(DB_CONNECTION)" = "mysql" ] ; \
	then \
		docker-compose --env-file $(SRC).env up --build --detach ; \
		docker-compose --env-file $(SRC).env exec app bash -c \
			'php artisan migrate:fresh; php artisan config:cache' ; \
	fi ;

shell: run ##- A Bash shell into the app container.
	if [ "$(DB_CONNECTION)" = "sqlite" ] ; \
	then \
		docker exec --env-file $(SRC).env -it apiblog-sqlite \
			bash ; \
	elif [ "$(DB_CONNECTION)" = "mysql" ] ; \
	then \
		docker-compose --env-file $(SRC).env exec -it app \
			bash ; \
	fi ;

test-db: run ##- Gets to the database client prompt.
	if [ "$(DB_CONNECTION)" = "sqlite" ] ; \
	then \
		sqlite3 $(SRC)database/database.sqlite ; \
	elif [ "$(DB_CONNECTION)" = "mysql" ] ; \
	then \
		docker-compose --env-file $(SRC).env exec -it $(DB_HOST) \
			mysql -u$(DB_USERNAME) -p $(DB_DATABASE) ; \
	fi ;

dump: run ##- Dumps database content in SQL format to database/schema/.
	cd $(SRC) && \
	php artisan schema:dump

test-api: $(SRC).env ##- Simple HTTP get requests for posts and comments.
	cd $(SRC) && \
		php artisan route:list --path api && \
		curl -sL $(APP_URL)/api/comments/1/post

publish: run ##- Publishes generated images to Docker HUB (must be logged in previously).
	git push github --all && git push gitlab --all
	docker push mfandrade/apiblog:sqlite 2>/dev/null
	docker push mfandrade/apiblog:latest 2>/dev/null

help: ##- This message.
	@echo 'USAGE: make <TARGET> [VARNAME=value]'
	@echo
	@echo 'TARGET can be:'
	@sed -e '/#\{2\}-/!d; s/\\$$//; s/:[^#\t]*/\t- /; s/#\{2\}- *//' $(MAKEFILE_LIST)
