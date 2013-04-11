source 'https://rubygems.org'

gem 'rails', github: 'rails/rails'

gem 'pg'

group :assets do
  gem 'sass-rails', '~> 4.0.0.beta1'
  gem 'coffee-rails', '~> 4.0.0.beta1'

  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass-rails'
end

gem 'jquery-rails'

gem 'ember-rails', github: 'emberjs/ember-rails'

group :development do
  gem 'rb-fsevent', '~> 0.9'
  gem "guard-livereload"
end

# RSS Parsing
gem 'feedzirra', github: 'pauldix/feedzirra'

# Image Uploads
gem 'fog', '1.3.1'
gem 'carrierwave', github: 'jnicklas/carrierwave'
gem "rmagick", "2.12.0"

# User Authentication
gem 'devise', github: 'plataformatec/devise', branch: 'rails4'

# Queues
gem "resque", github: 'resque/resque', branch: '1-x-stable'

# Deploying
gem 'foreman'
gem 'capistrano'

# Production Server
gem 'unicorn'

# Cron Job Scheduling
gem 'whenever', require: false

# Simple Database Backups
gem 'aws-s3', require: false
