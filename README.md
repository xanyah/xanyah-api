# Xanyah API

[![Travis CI](https://img.shields.io/travis/xanyah/xanyah-api.svg)](https://travis-ci.org/xanyah/xanyah-api) [![CodeClimate](https://img.shields.io/codeclimate/github/xanyah/xanyah-api.svg)](https://codeclimate.com/github/xanyah/xanyah-api) [![CodeClimate test coverage](https://img.shields.io/codeclimate/coverage/github/xanyah/xanyah-api.svg)](https://codeclimate.com/github/xanyah/xanyah-api) [![CodeClimate maintenability](https://img.shields.io/codeclimate/maintainability/xanyah/xanyah-api.svg)](https://codeclimate.com/github/xanyah/xanyah-api)

## Installation

- Clone this repo
- Copy `.env.example` into `.env` (or `.env.test` depending on your environments)
- Install gems: `bundle install`
- Set up your database:
  - Create it with Docker-Compose by running `docker-compose up`
  - Run the migrations: `rake db:migrate`
- You're all set ! :tada:

## Our stack

- Ruby on Rails
- CI: [Travis CI](https://travis-ci.org/xanyah/xanyah-api)
- Code Analysis: [CodeClimate](https://codeclimate.com/github/xanyah/xanyah-api)

## Contributing

:+1::tada: Pull requests are welcome ! :tada::+1:
