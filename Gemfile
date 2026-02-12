source 'https://rubygems.org'

ruby '3.3.4'

gem 'rails', '~> 7.1.3'

#
# PLATFORM SPECIFIC
#
# OSX
gem 'rb-fsevent', group: [:development, :test]        # monitor file changes without hammering the disk
gem 'terminal-notifier-guard', group: [:development]  # notify terminal when specs run
gem 'terminal-notifier', group: [:development]
# LINUX
# gem 'rb-inotify', :group => [:development, :test]   # monitor file changes without hammering the disk



# Monitoring
gem 'rack-timeout', '~> 0.1.0beta4'
# gem 'newrelic_rpm'               # very old version; incompatible with Ruby 3.3 (uses Fixnum, etc.)
# gem 'airbrake', '~> 3.2.1'       # very old version; incompatible with Ruby 3.3 (Fixnum in builder)
# gem 'airbrake_user_attributes'  # use with self-hosted errbit; see config/initializers/airbrake.rb
# gem 'rack-google-analytics'

# Data
gem 'pg', '~> 1.1'
gem 'dalli'                     # memcached
# gem 'schema_plus'             # add better index and foreign key support
# gem 'jbuilder'

# Web / Server
gem 'puma', '~> 6.4'
gem 'webrick', '~> 1.8'

# Core / JSON
# Force a modern json gem compatible with Ruby 3.3 (older 1.8.x releases won't compile)
gem 'json', '~> 2.7'

# Assets
gem 'sass-rails'
gem 'haml', '~> 6.3'
gem 'haml-rails', '~> 2.1'
gem 'simple_form'
gem 'uglifier'
gem 'headjs-rails'

# Javascript
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'nprogress-rails'

# CoffeeScript
# Not needed in production if precompiling assets
gem 'coffee-rails'
# Uncomment if node.js is not installed
# gem 'therubyracer', platforms: :ruby

# Design
# gem 'bootstrap-sass'
gem 'bootstrap-sass', '~> 3.4.1'
# gem 'bourbon'
# gem 'neat'
# gem 'country_select'

# Email
# gem 'premailer-rails'           # old css_parser version incompatible with modern Ruby Regexp API

# Authentication
gem 'devise'
gem 'cancancan', '~> 1.9'
gem 'omniauth'
gem 'omniauth-facebook'
# gem 'omniauth-twitter'
# gem 'omniauth-persona'
# gem 'omniauth-google-oauth2'
# gem 'omniauth-linkedin'

# Admin
# gem 'rails_admin'              # old version depends on kaminari, which uses alias_method_chain not present in Rails 7

# Workers
gem 'sidekiq'
# gem 'devise-async'              # legacy Devise extension; incompatible behavior on modern Devise/Ruby
gem 'sinatra', require: false

# Utils
gem 'addressable'
gem 'settingslogic'
gem 'ffi', '~> 1.16'
gem 'bcrypt', '~> 3.1.20'

group :development do
  # Docs
  gem 'sdoc', require: false    # bundle exec rake doc:rails

  # Errors
  # gem 'better_errors'
  # gem 'binding_of_caller'     # extra features for better_errors
  # gem 'meta_request'          # for rails_panel chrome extension

  # Deployment
  # gem 'capistrano'

  # Guard
  # gem 'guard-rspec'             # old guard/pry versions incompatible with Ruby 3.3
  # gem 'guard-livereload'
  # gem 'rack-livereload'
end

group :development, :test do
  # Use spring or zeus
  gem 'spring'                  # keep application running in the background
  gem 'spring-commands-rspec'
  # gem 'zeus'                  # required in gemfile for guard

  # Debugging
  # gem 'pry'                   # better than irb
  # gem 'byebug'                # ruby 2.0 debugger with built-in pry
  # gem 'pry-rails'             # adds rails specific commands to pry (old version incompatible with Ruby 3.3)
  # gem 'pry-byebug'            # add debugging commands to pry (incompatible with Ruby 3.3 with this version)
  # gem 'pry-stack_explorer'    # navigate call stack (pulls in binding_of_caller which is incompatible with Ruby 3.3)
  # gem 'pry-rescue'            # start pry session on uncaught exception
  # gem 'pry-doc'               # browse docs from console
  # gem 'pry-git'               # add git support to console
  # gem 'pry-remote'            # connect remotely to pry console
  # gem 'coolline'              # sytax highlighting as you type
  # gem 'coderay'               # use with coolline
  gem 'awesome_print'           # pretty pring debugging output

  # Testing
  # gem 'rspec-rails'             # temporarily disabled; old rspec/rake integration incompatible with modern Rake
  gem 'factory_girl_rails'
  gem 'ffaker'
  # gem 'capybara-webkit'       # requires Qt/qmake and is very outdated; replace with modern drivers if needed
  # gem 'poltergeist'           # alternative to capybara-webkit
  # gem 'capybara-firebug'
  # gem 'launchy'               # save_and_open_page support for rspec
  # gem 'zeus-parallel_tests'   # speed up lengthy tests

  # Logging
  # gem 'quiet_assets'
end

group :test do
  gem 'minitest'                # include minitest to prevent require 'minitest/autorun' warnings

  # Helpers
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  # gem 'timecop'               # Mock Time

  # Coverage
  gem 'simplecov', require: false
  # gem 'coveralls', :require => false

  gem 'rspec-sidekiq'
  gem 'rspec-activemodel-mocks'
end
group :development, :test do

  gem 'byebug', platforms: :mri
end

group :production do
  gem 'memcachier'              # heroku add-on for auto config of dalli
  gem 'unicorn'
  gem 'rails_12factor'          # https://devcenter.heroku.com/articles/rails4
end

