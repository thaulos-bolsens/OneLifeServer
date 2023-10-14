rebuild:
	docker compose stop
	docker rm ohol-server
	docker rmi  onelifeserver_server
	make build
	make start

build:
	docker compose build

start:
	docker compose up -d

stop:
	docker compose stop

bash:
	docker exec -it ohol-server bash
