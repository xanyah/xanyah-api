# Xanyah API

[![Build Status](https://travis-ci.org/xanyah/xanyah-api.svg?branch=master)](https://travis-ci.org/xanyah/xanyah-api) [![Maintainability](https://api.codeclimate.com/v1/badges/db3496ab5acbbb203590/maintainability)](https://codeclimate.com/github/xanyah/xanyah-api/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/db3496ab5acbbb203590/test_coverage)](https://codeclimate.com/github/xanyah/xanyah-api/test_coverage)

## Installation

- Clone this repo
- Copy `.env.example` into `.env` (or `.env.test` depending on your environments)
- Install gems: `bundle install`
- Install packages: `yarn` or `npm install`
- Set up your database:
  - Create it with Docker-Compose by running `docker-compose up`
  - Run the migrations: `rake db:migrate`
- You're all set ! :tada:

## Generating docs

- `yarn docs`

## Our stack

- Ruby on Rails
- CI: [Travis CI](https://travis-ci.org/xanyah/xanyah-api)
- Code Analysis: [CodeClimate](https://codeclimate.com/github/xanyah/xanyah-api)

## Contributing

:+1::tada: Pull requests are welcome ! :tada::+1:
