# Xanyah API

[![Travis CI](https://img.shields.io/travis/xanyah/xanyah-api.svg)](https://travis-ci.org/xanyah/xanyah-api) [![CodeClimate maintenability](https://img.shields.io/codeclimate/github/xanyah/xanyah-api.svg)](https://codeclimate.com/github/xanyah/xanyah-api) [![CodeClimate test coverage](https://img.shields.io/codeclimate/coverage/github/xanyah/xanyah-api.svg)](https://codeclimate.com/github/xanyah/xanyah-api)

## Installation

- Clone this repo
- Copy `.env.example` into `.env` (Or refer to [`dotenv-rails` docs](https://github.com/bkeepers/dotenv#dotenv-))
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

## MIT License

Copyright (c) 2017 Xanyah

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
