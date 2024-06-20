# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.3.1
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Install Node.js for asset compilation
RUN apt-get update -qq && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="development" \
    BUNDLE_DEPLOYMENT="1" \

    BUNDLE_PATH="/usr/local/bundle"
    # BUNDLE_WITHOUT="development"


# Throw-away build stage to reduce size of final image
FROM base as build

# Install packages needed to build gems and Node.js for ExecJS
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libvips pkg-config nodejs

# Install Node.js and other dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y apt-utils nodejs npm libpq-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Adjust binfiles to be executable on Linux
RUN chmod +x bin/* && \
    sed -i "s/\r$//g" bin/* && \
    sed -i 's/ruby\.exe$/ruby/' bin/*

# ARG RAILS_MASTER_KEY
# ENV RAILS_MASTER_KEY=$RAILS_MASTER_KEY

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
# RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile --trace
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile
# RUN SECRET_KEY_BASE=1 RAILS_BUILD=1 bundle exec rake assets:precompile
# RUN ASSETS_PRECOMPILE=1 SECRET_KEY_BASE=1 RAILS_ENV=production bundle exec rake assets:precompile

# Final stage for app image
FROM base

# Install packages needed for deployment, including Node.js
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libsqlite3-0 libvips nodejs && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy built artifacts: gems, application
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Run and own only the runtime files as a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

# Entrypoint prepares the database.
# ENTRYPOINT ["/rails/bin/docker-entrypoint"]


# Start the server by default, this can be overwritten at runtime
EXPOSE 8080

# # Define environment variable
# ENV PORT=8080

# Run the app
CMD ["bundle", "exec","rails", "server", "-b", "0.0.0.0", "-p", "8080"]


