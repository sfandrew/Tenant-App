source 'https://rubygems.org'

ruby '2.2.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.11'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

gem 'will_paginate-bootstrap'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# User auth
gem 'devise'

# seed data from db
gem 'seed_dump'
#api for entries
gem 'active_model_serializers'

gem 'pry'
gem 'rmagick', '2.13.2'
gem 'carrierwave'
gem 'carrierwave_direct'
gem 'fog'
gem 'sidekiq'

gem 'exception_notification'

#facebook login
gem 'omniauth-facebook'
#gmail login
gem "omniauth-google-oauth2"
#app payment
gem 'braintree'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]


#ruby "2.1.1"

#DEV - Dynamic Form Gem (via up one dir)
gem 'dynamic_forms_engine', :path => '../dynamic-forms-engine'

#PROD - Dynamic Form Gem via GIT (James)
# gem 'dynamic_forms_engine', git: "https://4be3166eb32f5bbd09980a6e111815d526767f64:x-oauth-basic@github.com/maxkaplan/dynamic-forms-engine.git"

##pdf generation 
gem 'wicked_pdf'
##wrapper for wkhtmltopdf
gem 'wkhtmltopdf-binary'
#encryption
gem "strongbox"

group :test do
	gem 'sqlite3'
end

group :development, :test do
	gem 'brakeman', :require => false
	gem 'factory_girl_rails'
	gem 'faker'
	gem 'meta_request'
	# gem 'pg'
	gem 'mysql2'
	# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
	gem 'spring'
	gem 'rails-footnotes', '~> 4.0'
	gem "better_errors"
	gem "binding_of_caller"
	gem 'rspec-rails', '~> 3.0'
	gem 'rails-perftest'
	gem 'rack-mini-profiler'
end

group :production do
	gem 'pg'
	gem 'rails_12factor'
	gem 'puma'
end
