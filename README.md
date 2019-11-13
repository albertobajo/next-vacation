# README

## Requirements

* [Docker Desktop](https://www.docker.com/products/docker-desktop)

## Installation

From the project folder, run bundle:
```
$ docker-compose run web bundle install
```

Build the app:
```
$ docker-compose build
```

Start the containers:
```
$ docker-compose up
```

Create and migrate the database:

```
$ docker-compose run web bundle exec rails db:create db:migrate
```

## RSpec
```
$ docker-compose run web bundle exec rspec
```

## Guard
```
$ docker-compose run web bundle exec guard --clear
```

## Program requirements

### 1. Load the provided activities file

There is a rake task for loading `madrid.json` file placed in folder `lib/assets`.

With Bash:
```
$ docker-compose run web bundle exec rake activities:load[lib/assets/madrid.json,Madrid]
```

With ZSH:
```
$ docker-compose run web bundle exec rake activities:load\[lib/assets/madrid.json,Madrid\]
```

### 2. Create an endpoint that returns all available activities

Some examples:

- [http://localhost:3000/api/v1/activities.json](http://localhost:3000/api/v1/activities.json)
- [http://localhost:3000/api/v1/activities.json?category=cultural](http://localhost:3000/api/v1/activities.json?category=cultural)
- [http://localhost:3000/api/v1/activities.json?category=cultural&location=indoors](http://localhost:3000/api/v1/activities.json?category=cultural&location=indoors)
- [http://localhost:3000/api/v1/activities.json?category=cultural&location=indoors&district=Retiro](http://localhost:3000/api/v1/activities.json?category=cultural&location=indoors&district=Retiro)

### 3. Create an endpoint to recommend what to do at a given time

Some examples:

Same day:

- [http://localhost:3000/api/v1/recommended_activity.json?category=cultural&from=201912121300&to=201912121800](http://localhost:3000/api/v1/recommended_activity.json?category=cultural&from=201912121300&to=201912121800)

Multiple days:
- [http://localhost:3000/api/v1/recommended_activity.json?category=cultural&from=201212181800&to=201212191230](http://localhost:3000/api/v1/recommended_activity.json?category=cultural&from=201212181800&to=201212191230)
- [http://localhost:3000/api/v1/recommended_activity.json?category=cultural&from=201212181800&to=201212191300](http://localhost:3000/api/v1/recommended_activity.json?category=cultural&from=201212181800&to=201212191300)