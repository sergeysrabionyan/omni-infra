build: build-omni

PROJECT_NAME_APP := omni-app

build-omni:
	cd omni-app && make all
	docker-compose -f docker-compose.yml build ${PROJECT_NAME_APP}
	docker-compose -f docker-compose.yml up -d
	docker-compose -f docker-compose.yml exec ${PROJECT_NAME_APP} composer install
	docker-compose -f docker-compose.yml exec ${PROJECT_NAME_APP} php artisan migrate
	docker-compose -f docker-compose.yml exec ${PROJECT_NAME_APP} php artisan passport:install
	docker-compose -f docker-compose.yml exec ${PROJECT_NAME_APP} php artisan db:seed
	docker-compose -f docker-compose.yml exec ${PROJECT_NAME_APP} php artisan storage:link
	docker-compose -f docker-compose.yml down

omni:
	docker exec -it ${PROJECT_NAME_APP} bash

up:
	cd omni-app
	docker-compose up -d

down:
	cd omni-app
	docker-compose down