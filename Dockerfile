FROM ruby:3.4.4

# Set the working directory inside the container
WORKDIR /srv/jekyll

# Copy Gemfile and Gemfile.lock (if present) to leverage Docker's layer caching
COPY Gemfile Gemfile.lock ./

# Install Jekyll and its dependencies
RUN bundle install

# Copy your Jekyll site files into the container
COPY . /srv/jekyll

# Expose the default Jekyll server port
EXPOSE 4000

# Command to build and serve the Jekyll site
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]