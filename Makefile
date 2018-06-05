up: build
	docker-compose up daemon

shell: build
	docker-compose run --rm daemon sh

build:
	docker-compose build
