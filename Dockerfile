FROM ruby:2.6.5
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
    tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y build-essential nodejs postgresql-client yarn \
    && apt-get install -y libgeos-3.7.1 libgeos-dev postgis redis-server
RUN mkdir /next-vacation
WORKDIR /next-vacation
COPY Gemfile /next-vacation/Gemfile
COPY Gemfile.lock /next-vacation/Gemfile.lock
RUN bundle install
COPY . /next-vacation

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
