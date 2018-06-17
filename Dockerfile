FROM ruby:2.4.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs && apt-get install vim
RUN mkdir /myapp

WORKDIR /myapp

ADD . /myapp
RUN bundle install --without development test


# Make port 3000 available to the world outside this container
EXPOSE 3000
