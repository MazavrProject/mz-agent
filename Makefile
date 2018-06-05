up: build
	docker-compose up

shell: build
	docker-compose run --rm daemon sh

build:
	docker-compose build
