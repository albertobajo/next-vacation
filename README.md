# README

<!--
* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

-->

## Requirements

* [Docker Desktop](https://www.docker.com/products/docker-desktop)

## Docker Setup

From the project folder, start the containers:

```
$ docker-compose up
```

Create and load database schema:

```
$ docker-compose run web rake db:setup
```

Navigate to the application’s root at [http://localhost:3000](http://localhost:3000)
