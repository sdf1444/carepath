FROM ruby:3.3.8-slim
RUN apt-get update -qq && apt-get install --no-install-recommends -y build-essential libpq-dev postgresql-client curl && rm -rf /var/lib/apt/lists/*
WORKDIR /rails
COPY Gemfile ./
RUN bundle install
COPY . .
EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
