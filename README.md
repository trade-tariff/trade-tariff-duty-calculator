# Trade Tariff Duty Calculator

[![CircleCI](https://circleci.com/gh/trade-tariff/trade-tariff-duty-calculator.svg?style=shield&circle-token=f1a191a029869bd8bb94a9fd721b663f4653ca49)](https://app.circleci.com/pipelines/github/trade-tariff/trade-tariff-duty-calculator)

## Prerequisites

- Ruby 3.2
- Rails 7.0
- NodeJS & Yarn

> Make sure you install and enable all pre-commit hooks https://pre-commit.com/

## Setting up the app in development

> Make sure you install and enable all pre-commit hooks https://pre-commit.com/

1. Run `bin/setup`
2. Followed by `bin/rails s`
3. Navigate to <http://localhost:3002>

## Whats included?

- Rails 7.0 with Webpacker
- [GOV.UK Frontend](https://github.com/alphagov/govuk-frontend)
- RSpec
- Dotenv (managing environment variables)

## Running specs

```sh
bundle exec rspec
```

## Running locally in docker-compose

You'll need:

- Working Docker environment
- Docker-compose installed

### Run

1. Clone this repo and change to it's root directory
2. Run ``docker-compose up``
3. Open your browser to `http://0.0.0.0:3000/duty-calculator/ping`
   to verify it's running.
4. Start the journey with the commodity ID you want to test
  (It uses the dev environment API by default)

e.g `http://0.0.0.0:3000/duty-calculator/uk/9620001000/import-date`
