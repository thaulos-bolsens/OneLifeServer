rebuild:
	docker compose stop || true
	docker rm ohol-builder || true
	docker rmi onelifeserver_builder || true
	make build
	make start

build:
	docker compose build

start:
	docker compose up -d

stop:
	docker compose stop

bash:
	docker exec -it ohol-builder bash
