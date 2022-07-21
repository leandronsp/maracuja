FROM ruby:3.1 AS base
WORKDIR /app

FROM base AS dev

FROM base AS release
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle
ADD . .
EXPOSE 3000
CMD ["ruby", "server.rb"]
