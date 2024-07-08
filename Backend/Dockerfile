# Use the official Ruby image from Docker Hub
FROM ruby:3.3.1

# Set the working directory in the container
WORKDIR /app

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential bash-completion libffi-dev tzdata git libvips libpq-dev nodejs npm && \
    npm install -g yarn

ARG MASTER_KEY
ENV RAILS_MASTER_KEY=${MASTER_KEY}

# # Install Cloud SQL Proxy
# RUN wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O cloud_sql_proxy && \
#     chmod +x cloud_sql_proxy

# # Copy the setup script and make it executable
# COPY scripts/setupdb.sh /usr/local/bin/setupdb.sh
# RUN chmod +x /usr/local/bin/setupdb.sh

# Copy Gemfile and Gemfile.lock and install gems
COPY Gemfile Gemfile.lock ./

RUN gem install bundler

RUN bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test'

RUN bundle install
# RUN bundle install

# Copy the application code into the container
COPY . /app


# Set production environment variables
ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_SERVE_STATIC_FILES=true
ENV SECRET_KEY_BASE=563915888282c710e5def9c751f9f8ec1438aec954321e7c8e5fba801ac12b8731061c39f7722c2000a04fad3e0e34ec1c2d9d746b1049b6d329b69b3fcbe135

# RUN mkdir /cloudsql && \
#     touch /cloudsql/team6sds:asia-southeast1:natgallerysql

RUN yarn install --silent && \
    yarn add tailwindcss-animate flowbite 
    # webpack webpack-cli shakapacker webpack-assets-manifest
    

# Precompile assets, create and migrate the database, and seed if necessary
RUN bundle exec rake assets:precompile --trace


# ENTRYPOINT ["scripts/setupdb.sh"]
# Expose port 8080 to the Docker host, so we can access Rails server
EXPOSE 8080

# Start Cloud SQL Proxy in the background and then start the Rails server
# CMD ["sh", "-c", "./cloud_sql_proxy -dir=/cloudsql -instances=team6sds:asia-southeast1:natgallerysql=tcp:5432 & bundle exec rails server -b 0.0.0.0 -p 8080"]
# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "8080"]
