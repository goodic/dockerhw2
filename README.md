# Склады и товары

## Сборка контейнера

Перейдите в папку с проектом. Отредактируйте файл _.env_. Укажите свой SECRET_KEY

Соберите контейнер командой

```bash
docker build -t stocks ./
```
Для нормальной работы сервиса требуется создать и смонтировать при запуске volume для хранени БД

```bash
docker volume create stocksdb
 ```
И запустите контейнер с сервисом командой 
```bash
docker run --publish 8000:8000 --detach --name stocks --mount source=stocksdb,target=/code/db stocks
```

После запуска контейнера необходимо создать учетную запись admin. Для этого выполните команду

```bash
docker exec -it stocks python manage.py createsuperuser
```

## Примеры API-запросов

@baseUrl = http://localhost:8000/api/v1

### Создание продукта
POST {{baseUrl}}/products/\
Content-Type: application/json
```json
{
  "title": "Помидор",
  "description": "Лучшие помидоры на рынке"
}
```

### Получение продуктов
GET {{baseUrl}}/products/\
Content-Type: application/json

### Обновление продукта
PATCH {{baseUrl}}/products/1/\
Content-Type: application/json
```json
{
  "description": "Самые сочные и ароматные помидорки"
}
```

### Удаление продукта
DELETE {{baseUrl}}/products/1/\
Content-Type: application/json

### Поиск продуктов по названию и описанию
GET {{baseUrl}}/products/?search=помидор\
Content-Type: application/json

### Создание склада
POST {{baseUrl}}/stocks/\
Content-Type: application/json
```json
{
  "address": "мой адрес не дом и не улица, мой адрес сегодня такой: www.ленинград-спб.ru3",
  "positions": [
    {
      "product": 2,
      "quantity": 250,
      "price": 120.50
    },
    {
      "product": 3,
      "quantity": 100,
      "price": 180
    }
  ]
}
```
### Обновляем записи на складе
PATCH {{baseUrl}}/stocks/4/\
Content-Type: application/json

```json
{
  "positions": [
    {
      "product": 2,
      "quantity": 100,
      "price": 130.80
    },
    {
      "product": 3,
      "quantity": 243,
      "price": 145
    }
  ]
}
```
### Поиск складов, где есть определенный продукт
GET {{baseUrl}}/stocks/?products=2\
Content-Type: application/json
