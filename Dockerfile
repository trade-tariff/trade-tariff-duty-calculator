# Build compilation image
FROM ruby:3.1.0-alpine3.15 as builder

# The application runs from /app
WORKDIR /app

ENV RAILS_SERVE_STATIC_FILES=true \
    RAILS_ENV=production \
    BUNDLE_APP_CONFIG=/app/vendor/bundle

# build-base: compilation tools for bundle
# git: used to pull gems from git
# yarn: node package manager
RUN apk add --update --no-cache build-base git yarn tzdata && \
  cp /usr/share/zoneinfo/Europe/London /etc/localtime && \
  echo "Europe/London" > /etc/timezone

COPY . /app
# COPY .ruby-version Gemfile Gemfile.lock /app/
# COPY ./vendor /app/vendor
# COPY package.json yarn.lock /app/

# Pull ruby deps
RUN bundle config path /app/vendor/bundle \
  && bundle install --jobs=4 --no-binstubs

# Pull js deps
RUN yarn install --frozen-lockfile

# Compile assets
RUN bundle exec rails assets:precompile

# Build runtime image
FROM ruby:3.1.0-alpine3.15 as production

RUN apk add --update --no-cache tzdata && \
  cp /usr/share/zoneinfo/Europe/London /etc/localtime && \
  echo "Europe/London" > /etc/timezone

WORKDIR /app

COPY --from=builder /app /app

RUN bundle config path /app/vendor/bundle

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
