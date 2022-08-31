# Social Media API
![Dart badge](https://img.shields.io/badge/Dart-blue?logo=Dart)
![PostgreSQL badge](https://img.shields.io/badge/PostgreSQL-202020?logo=postgresql)
![Prisma badge](https://img.shields.io/badge/Prisma-202020?logo=Prisma)


This Rest API performs all CRUD actions over the `Post` entity

## Requirements
- [Prisma](https://www.prisma.io/)

## Setup
To properly set up this API you may follow a few step

### Set up Database
Before execute this API you may set up a PostgreSQL database.

### Configure `.env` variables
On project's root folder add `.env` file.
`.env` file content:

```
DATABASE_URL="WRITE-YOUR-DATABASE-URL-HERE"
```
### Import Database models
To import all database models required, open a terminal and run the command above.
```
prisma db push
```
### Run API
To run this API, you may open a terminal and run the command above.

```
  dart pub get
  dart run
```
