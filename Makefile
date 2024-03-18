help:           ## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

checkout_pull:
	git submodule foreach --recursive git fetch --all && \
	git submodule foreach --recursive git stash && \
	git submodule foreach --recursive git checkout -B $${branch} && \
	git pull --recurse-submodules && \
	git submodule update --init --recursive


common_compose_params=--env-file composer-files/.db.docker_compose.env \
                      --env-file composer-files/rabbitmq/3.11/.docker_compose.env \
                      --env-file composer-files/elasticsearch/8.12.0/.docker_compose.env \
                      --env-file ./.env \
                      -f composer-files/docker-compose.common.yml \
                      -f composer-files/docker-compose.db.yml \
                      -f composer-files/nginx/docker-compose.yml \
                      -f composer-files/rabbitmq/3.11/docker-compose.yml \
                      -f composer-files/elasticsearch/8.12.0/docker-compose.yml \
                      -f composer-files/kibana/8.12.0/docker-compose.yml \
                      -f composer-files/filebeat/7.6.0/docker-compose.yml

apps_compose_params=-f ads_monolit/docker-compose.yml \
                    -f ads_microservice/docker-compose.yml \
                    -f auth_microservice/docker-compose.yml \
                    -f geocoder_microservice/docker-compose.yml

override_compose_params=-f docker-compose.override.yml

build:
	docker-compose ${common_compose_params} ${apps_compose_params} ${override_compose_params} build

rebuild:
	docker-compose ${common_compose_params} ${apps_compose_params} ${override_compose_params} build --no-cache

up-services:
	docker-compose ${common_compose_params} ${override_compose_params} up db

up-all: ##
	docker compose ${common_compose_params} ${apps_compose_params} ${override_compose_params} up

up-db: ##
	docker-compose ${common_compose_params} ${override_compose_params} up db

down: ##
	docker-compose ${common_compose_params} ${apps_compose_params} ${override_compose_params} down --remove-orphans

up-builder: ##
	docker-compose --env-file ./.env -f docker-compose.builder.yml up

close_connections_sql="REVOKE CONNECT ON DATABASE $${target_db} FROM PUBLIC; \
             SELECT \
               pg_terminate_backend(pid) \
             FROM \
               pg_stat_activity \
             WHERE \
               pid <> pg_backend_pid() \
               AND datname = '$${target_db}';"

drop_target_db="DROP DATABASE $${target_db};"

recreate_target_db="SELECT 'CREATE DATABASE $${target_db}' \
                    WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '$${target_db}');"

drop-target-db:
	 docker-compose ${common_compose_params} exec db psql -U postgres -c ${drop_target_db}

close-sessions-target-db:
	 docker-compose ${common_compose_params} exec db psql -U postgres -c ${close_connections_sql}

create-target-db:
	 docker-compose ${common_compose_params} exec db psql -U postgres -c '\gexec' -c ${recreate_target_db}

restore-to-target-db:
	 make create-target-db && make close-sessions-target-db && make drop-target-db && make create-target-db; \
	 docker-compose ${common_compose_params} exec -T db psql -U postgres -d $${target_db} < $${dump_file};


