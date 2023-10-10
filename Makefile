rebuild:
	docker compose stop
	make build
	make start

build:
	docker rm ohol-server
	docker rmi  onelifeserver_server
	docker compose build

start:
	docker compose up -d

stop:
	docker compose stop

bash:
	docker exec -it ohol-server bash
