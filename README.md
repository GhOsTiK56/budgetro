
# Техническое задание

##  «Разработка мобильного приложения для управления личными финансами с аналитикой расходов»

---
## 1. Общие сведения

**Тип проекта:** Fullstack — мобильное приложение + микросервисный бэкенд + AI-модуль **Платформы:** Android 8.0+, iOS 14+ **Архитектура бэкенда:** Микросервисная (gRPC + RabbitMQ) **Назначение:** Учёт доходов и расходов, категоризация транзакций, визуальная аналитика, управление бюджетом, push-уведомления и AI-функциональность на базе GPT-4o-mini

---
## 2. Стек технологий

### Frontend — Mobile

|Технология|Назначение|
|---|---|
|Flutter 3.x (Dart 3.x)|UI-фреймворк|
|Riverpod 2.x|State management|
|Go Router|Навигация и deep links|
|Freezed + json_serializable|Иммутабельные модели, маппинг DTO ↔ Entity|
|Dio|HTTP-клиент, интерцепторы|
|Flutter Secure Storage|Безопасное хранение JWT-токенов|
|FL Chart|Графики и диаграммы аналитики|
|Firebase Messaging|Получение push-уведомлений (FCM)|
|Intl|Форматирование дат и валют|

### Backend — Микросервисы

| Сервис               | Технологии                | Назначение                                 |
| -------------------- | ------------------------- | ------------------------------------------ |
| API Gateway          | NestJS + TypeScript       | Единая точка входа, роутинг, rate limiting |
| Auth Service         | NestJS + Prisma + Redis   | JWT, refresh токены, OTP                   |
| Users Service        | NestJS + Prisma           | Профили пользователей                      |
| Transactions Service | NestJS + Prisma + Redis   | CRUD транзакций, кэширование               |
| Analytics Service    | NestJS + Prisma + Redis   | Агрегация, статистика, прогнозы            |
| Budget Service       | NestJS + Prisma           | Лимиты по категориям                       |
| AI Service           | NestJS + OpenAI API       | Категоризация, чат, аномалии               |
| Notification Service | NestJS + FCM + Nodemailer | Push и email уведомления                   |

### Межсервисное взаимодействие

|Технология|Назначение|
|---|---|
|gRPC + Protocol Buffers|Синхронная связь между сервисами|
|RabbitMQ|Асинхронные события (уведомления, аномалии)|
|Redis|Кэш аналитики, хранение OTP и сессий|

### Observability

|Технология|Назначение|
|---|---|
|Prometheus|Сбор метрик с каждого сервиса|
|Grafana|Визуализация метрик, дашборды|
|Jaeger|Distributed tracing запросов|
|Loki + Promtail|Централизованное логирование|

### DevOps & Инфраструктура

|Технология|Назначение|
|---|---|
|Docker + docker-compose|Контейнеризация всех сервисов|
|Railway|Деплой бэкенда и БД|
|GitHub Actions|CI/CD (lint → test → build → deploy)|
|Nginx|Reverse proxy перед Gateway|

---

## 3. Архитектура системы

### Общая схема

```
Flutter App
     │  REST / SSE
     ▼
  Nginx
     │
     ▼
 API Gateway (NestJS)
     │
     ├──[gRPC]──► Auth Service        (JWT, refresh, OTP)
     │                 │
     │            [RabbitMQ: auth.events]
     │                 ▼
     ├──[gRPC]──► Notification Service (FCM, Email)
     │
     ├──[gRPC]──► Users Service        (профили, аватары)
     │
     ├──[gRPC]──► Transactions Service (CRUD, Redis cache)
     │                 │
     │            [RabbitMQ: transaction.created]
     │
     ├──[gRPC]──► Analytics Service   (агрегация, прогнозы)
     │                 │
     │            [Redis cache]
     │
     ├──[gRPC]──► Budget Service      (лимиты, прогресс)
     │                 │
     │            [RabbitMQ: budget.exceeded]
     │
     └──[gRPC]──► AI Service          (OpenAI, чат, аномалии)
```

### Contracts — единый реестр Proto-файлов

Отдельный NPM-пакет `@finance-app/contracts` публикуется через GitHub Actions и содержит все `.proto` файлы и сгенерированные TypeScript-типы. Каждый сервис подключает его как зависимость.

```
contracts/
├── proto/
│   ├── auth.proto
│   ├── users.proto
│   ├── transactions.proto
│   ├── analytics.proto
│   ├── budget.proto
│   ├── ai.proto
│   └── notification.proto
└── generated/         # Автогенерация при публикации
```

### Mobile — Clean Architecture + Feature-first

```
lib/
├── core/
│   ├── network/        # Dio клиент, интерцепторы, SSE
│   ├── security/       # Хранение токенов, refresh логика
│   ├── di/             # Riverpod провайдеры
│   └── utils/          # Форматтеры, константы, расширения
├── features/
│   ├── auth/
│   │   ├── data/       # DTO, datasource, repository impl
│   │   ├── domain/     # Entity, IRepository, UseCases
│   │   └── presentation/
│   ├── transactions/
│   ├── categories/
│   ├── analytics/
│   ├── budget/
│   └── ai/
└── shared/
    ├── widgets/
    ├── theme/
    └── extensions/
```

### Backend — структура каждого сервиса (NestJS)

```
src/
├── modules/
│   └── [domain]/
│       ├── controller.ts      # gRPC handlers
│       ├── service.ts         # Бизнес-логика
│       ├── repository.ts      # Prisma запросы
│       └── dto/
├── common/
│   ├── filters/               # GrpcExceptionFilter
│   ├── interceptors/          # Logging, Tracing
│   └── pipes/                 # ValidationPipe
├── prisma/                    # Schema + migrations
├── config/                    # @nestjs/config + валидация env
└── main.ts                    # gRPC server bootstrap
```

---

## 4. Функциональные требования

### 4.1 Аутентификация (Auth Service)

- Регистрация и вход по email + пароль
- JWT: access token (15 мин) + refresh token (30 дней)
- Хранение refresh token в PostgreSQL хэшированным, ротация при обновлении
- OTP-верификация email при регистрации (генерация и хранение в Redis, TTL 5 мин)
- Хранение токенов на клиенте в Flutter Secure Storage
- Автообновление access token через Dio интерцептор

### 4.2 Пользователи (Users Service)

- Получение и редактирование профиля
- Загрузка аватара в Cloudinary
- Выбор основной валюты
- Хранение FCM-токена устройства для push-уведомлений

### 4.3 Транзакции (Transactions Service)

- Создание, редактирование, удаление транзакций (доход / расход)
- Поля: сумма, тип, категория, дата, комментарий
- Cursor-based пагинация
- Фильтрация по дате, категории, типу
- Поиск по комментарию
- При создании транзакции публикуется событие `transaction.created` в RabbitMQ
- Кэширование списка транзакций в Redis (инвалидация при изменении)

### 4.4 Категории (Transactions Service)

- Системные категории по умолчанию
- Создание и удаление пользовательских категорий (название, иконка, цвет)

### 4.5 Бюджетирование (Budget Service)

- Установка месячного лимита по каждой категории
- Отслеживание прогресса расходов относительно лимита
- При достижении 80% и 100% публикуется событие `budget.exceeded` в RabbitMQ
- Notification Service слушает событие и отправляет FCM push-уведомление

### 4.6 Аналитика (Analytics Service)

- Круговая диаграмма расходов по категориям за период
- Линейный график динамики доходов и расходов по месяцам
- Сравнение текущего месяца с предыдущим
- Агрегирующие SQL-запросы через Prisma
- Результаты кэшируются в Redis (TTL 1 час)
- Экспорт отчёта в PDF на клиенте

### 4.7 AI-функциональность (AI Service)

#### Умная категоризация транзакций

- Пользователь вводит описание («Пятёрочка», «Яндекс.Такси»)
- AI Service получает описание + список категорий пользователя, отправляет запрос в GPT-4o-mini
- Возвращается предложенная категория
- Прошлые выборы пользователя учитываются как контекст

#### AI-советник по бюджету (чат)

- Встроенный чат-экран в приложении
- GPT получает системный промпт с реальными данными: суммы по категориям, лимиты, история за месяц
- Ответы стримятся на клиент через SSE (Gateway → Flutter)
- История диалога сохраняется в PostgreSQL

#### Предсказание расходов на месяц

- Analytics Service агрегирует историю за 3–6 месяцев
- AI Service рассчитывает прогноз (скользящее среднее) и передаёт в GPT для текстовой интерпретации
- Отображается отдельным блоком на экране аналитики

#### Аномалии и предупреждения

- Cron-задача в AI Service запускается раз в день (@nestjs/schedule)
- Сравниваются текущие расходы со средними за 3 месяца
- При превышении на 40%+ GPT генерирует персонализированное сообщение
- Событие публикуется в RabbitMQ → Notification Service → FCM push

### 4.8 Уведомления (Notification Service)

- Слушает очереди RabbitMQ: `budget.exceeded`, `anomaly.detected`, `auth.otp`
- Отправка FCM push-уведомлений через Firebase Admin SDK
- Отправка email через Nodemailer
- Все отправленные уведомления сохраняются в БД

---

## 5. Схема баз данных

Каждый сервис имеет **собственную изолированную базу данных** (принцип Database per Service).

### Auth DB

- `users` — id, email, password_hash, created_at
- `refresh_tokens` — id, user_id, token_hash, expires_at, revoked

### Users DB

- `profiles` — id, user_id, name, avatar_url, currency, fcm_token

### Transactions DB

- `categories` — id, user_id (nullable), name, icon, color, type
- `transactions` — id, user_id, category_id, amount, type, note, date, created_at

### Budget DB

- `budgets` — id, user_id, category_id, amount, month, created_at

### Analytics DB

- Материализованные представления и агрегаты (через Prisma views)

### AI DB

- `ai_chat_messages` — id, user_id, role, content, created_at
- `categorization_history` — id, user_id, description, category_id, created_at

### Notification DB

- `notifications` — id, user_id, type, message, sent_at

---

## 6. Межсервисное взаимодействие

### gRPC (синхронное)

Все запросы от Gateway к сервисам идут через gRPC. Контракты описаны в `.proto` файлах пакета `@finance-app/contracts`.

### RabbitMQ (асинхронное)

|Exchange / Queue|Publisher|Consumer|Событие|
|---|---|---|---|
|`auth.otp`|Auth Service|Notification Service|Отправка OTP на email|
|`transaction.created`|Transactions Service|Analytics Service|Инвалидация кэша аналитики|
|`budget.exceeded`|Budget Service|Notification Service|Push при превышении лимита|
|`anomaly.detected`|AI Service|Notification Service|Push об аномальных расходах|

---

## 7. Observability

- **Prometheus** — каждый NestJS-сервис экспортирует метрики на `/metrics` (время ответа, количество запросов, ошибки)
- **Grafana** — единый дашборд для всех сервисов
- **Jaeger** — distributed tracing: каждый gRPC-запрос и RabbitMQ-событие имеет trace ID для отслеживания цепочки вызовов
- **Loki + Promtail** — централизованный сбор логов со всех контейнеров

---

## 8. Требования к безопасности

- Пароли хранятся только в виде bcrypt-хэша (salt rounds ≥ 12)
- Access и refresh токены — разные секреты, разные сроки жизни
- Refresh токены хранятся хэшированными, инвалидируются при выходе
- OpenAI API ключ хранится только в AI Service, клиент не имеет доступа
- В промпты GPT передаются только агрегированные данные без PII
- HTTPS на всех внешних эндпоинтах (Nginx + Railway)
- gRPC между сервисами работает во внутренней Docker-сети
- Валидация всех входящих DTO через class-validator на каждом сервисе
- Rate limiting на Gateway для эндпоинтов авторизации и AI-чата
- Helmet.js на Gateway
- Все секреты через `.env` + `@nestjs/config` с валидацией при старте

---

## 9. Требования к качеству кода

|Принцип|Реализация|
|---|---|
|**OOP**|Абстрактные репозитории и интерфейсы use cases на Flutter; модули, сервисы, контроллеры на NestJS|
|**DRY**|Shared `@finance-app/contracts` пакет; базовые классы репозиториев; общие интерцепторы|
|**Маппинг**|Flutter: `Freezed` + `json_serializable`, DTO ↔ Entity; NestJS: Proto ↔ Domain ↔ Response DTO|
|**SOLID**|Single Responsibility — каждый сервис одна зона ответственности; Dependency Inversion через NestJS IoC и Riverpod|
|**Null Safety**|Dart sound null safety; TypeScript strict mode|
|**Линтинг**|Flutter: `flutter_lints`; NestJS: ESLint + Prettier|
|**Именование**|snake_case в БД и proto, camelCase в коде, PascalCase для классов|

---

## 10. API Gateway — основные эндпоинты

```
POST   /auth/register
POST   /auth/login
POST   /auth/refresh
POST   /auth/logout
POST   /auth/verify-otp

GET    /users/me
PATCH  /users/me

GET    /transactions?cursor=&limit=&categoryId=&type=&from=&to=
POST   /transactions
PATCH  /transactions/:id
DELETE /transactions/:id

GET    /categories
POST   /categories
DELETE /categories/:id

GET    /budgets?month=
POST   /budgets
PATCH  /budgets/:id

GET    /analytics/summary?from=&to=
GET    /analytics/by-category?month=
GET    /analytics/trend?months=6

POST   /ai/categorize
POST   /ai/chat              # SSE стриминг
GET    /ai/chat/history
GET    /ai/forecast?month=
GET    /ai/anomalies
```

---

## 11. Деплой и инфраструктура

### docker-compose (локальная разработка)

Единый `docker-compose.yml` поднимает все сервисы, PostgreSQL (отдельный инстанс на каждый сервис), Redis, RabbitMQ, Jaeger, Prometheus, Grafana, Loki.

### Railway (продакшн)

- Каждый NestJS-сервис деплоится как отдельный Docker-контейнер
- Managed PostgreSQL для каждого сервиса
- Managed Redis
- Внутренняя сеть Railway для gRPC-связи между сервисами

### GitHub Actions (CI/CD)

- При пуше в `main`: ESLint → тесты → сборка Docker-образа → публикация в Container Registry → деплой на Railway
- При изменении `contracts/`: публикация обновлённого NPM-пакета

---

## 12. Нефункциональные требования

- Время отклика Gateway → сервис → ответ не более 500 мс
- Время первого токена AI-чата (стриминг) — не более 2 сек
- Офлайн-режим — кэширование последних данных на клиенте
- Адаптивный UI под разные размеры экрана
- Светлая и тёмная тема
- Покрытие unit-тестами: use cases (Flutter), сервисы NestJS, AI-сервисы (моки OpenAI)

---

## 13. Структура дипломной работы

1. Анализ предметной области и обзор аналогов
2. Проектирование системы — микросервисная архитектура, схема БД, UML-диаграммы (Use Case, Class, Sequence, Component)
3. Обоснование выбора стека технологий
4. Реализация инфраструктуры — gRPC, RabbitMQ, contracts-пакет, Docker
5. Реализация микросервисов — Auth, Users, Transactions, Analytics, Budget
6. Реализация AI-модуля — OpenAI интеграция, категоризация, чат, прогнозы, аномалии
7. Реализация мобильного приложения — Flutter, Clean Architecture, аналитика
8. Observability — Prometheus, Grafana, Jaeger, Loki
9. Тестирование — unit-тесты сервисов, интеграционное тестирование через Swagger
10. Заключение и перспективы развития