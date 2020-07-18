## Инфраструктура проекта OMNI

### Разворот проекта

Для разворота проекта необходимо:

- изменить имя файла `.env.infra` на `.env`

- запустить команду в корне проекта `make build`

#Запуск тестов:
   
    Unit тесты - make unit
    
    Integration тесты - make feature
    
    Все тесты - make test-all
   
    Один тест - make test-single TEST_PATH=[Абсолютный путь до теста]