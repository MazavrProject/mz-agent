FROM ruby:2.5-alpine

WORKDIR /app

RUN mkdir -p /app
COPY Gemfile* /app/
RUN bundle install

COPY . /app/

CMD ["ruby", "app.rb"]
