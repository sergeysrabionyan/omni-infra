build: build-omni

PROJECT_NAME_APP := omni-app
PROJECT_TEST_NAME_APP := omni-app-test

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

unit: test-backend-unit
test-backend-unit:
	docker-compose -f docker-compose-testing.yml up -d
	docker-compose -f docker-compose-testing.yml exec ${PROJECT_TEST_NAME_APP} vendor/bin/phpunit tests/Unit --colors=always
	docker-compose -f docker-compose-testing.yml down

feature: test-backend-feature
test-backend-feature:
	docker-compose -f docker-compose-testing.yml up -d
	docker-compose -f docker-compose-testing.yml exec ${PROJECT_TEST_NAME_APP} vendor/bin/phpunit tests/Feature --colors=always
	docker-compose -f docker-compose-testing.yml down

test-all: test-backend-all
test-backend-all:
	docker-compose -f docker-compose-testing.yml up -d
	docker-compose -f docker-compose-testing.yml exec ${PROJECT_TEST_NAME_APP} vendor/bin/phpunit --colors=always
	docker-compose -f docker-compose-testing.yml down

test-single: test-backend-single
test-backend-single:
	docker-compose -f docker-compose-testing.yml up -d
	docker-compose -f docker-compose-testing.yml exec ${PROJECT_TEST_NAME_APP} vendor/bin/phpunit ${TEST_PATH} --colors=always
	docker-compose -f docker-compose-testing.yml down
