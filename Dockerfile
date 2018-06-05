FROM ruby:2.5-alpine

RUN apk add --no-cache openssh-client
RUN mkdir -p /.ssh/
COPY docker/ssh_config /root/.ssh/config
COPY docker/id_rsa* /root/.ssh/

WORKDIR /app

RUN mkdir -p /app
COPY Gemfile* /app/
RUN bundle install

COPY . /app/

COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["ruby", "app.rb"]
