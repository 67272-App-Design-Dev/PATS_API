source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.5'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '1.0.2'

# For handling date validation
gem 'validates_timeliness', '4.0.2'

# For serializing models to json for the API
# gem 'active_model_serializers', '0.10.7'
gem 'fast_jsonapi', '1.5'

# For generating the swagger docs to document the API
gem 'swagger-docs', '0.2.9'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Additional gems that are very useful in Rails development
group :development do
  gem 'better_errors', '2.4.0'
  gem 'binding_of_caller', '0.8.0'
  gem 'meta_request', '0.5.0'
  gem 'hirb', '0.7.3'
  gem 'faker', '1.8.7'
end

# Gems used only in testing
group :test do
  gem 'shoulda', '2.11.3'
  gem 'shoulda-matchers', '3.1.2'
  gem 'factory_bot_rails', '4.8.2'
  gem 'simplecov', '0.16.1'
  gem 'cucumber-rails', '1.5.0', require: false
  gem 'database_cleaner', '1.6.2'
  gem 'launchy', '2.4.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
