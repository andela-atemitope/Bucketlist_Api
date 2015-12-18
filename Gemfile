source 'https://rubygems.org'


 
ruby "2.1.5"

gem 'rails', '4.2.4'

gem 'rails-api'

gem 'spring', :group => :development



gem 'jwt'

gem "figaro"

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
# To use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem "codeclimate-test-reporter", group: :test
# To use Jbuilder templates for JSON
# gem 'jbuilder'
gem 'simplecov', :require => false, :group => :test


gem "active_model_serializers", github: 'rails-api/active_model_serializers'

group :development, :test do
  # gem "rspec-rails"
  gem 'sqlite3'
  # gem "rspec_api_helpers"
  gem "database_cleaner"
  gem "pry"
  gem "pry-rails"
end

group :production do
  gem "pg",             "0.17.1"
  gem "rails_12factor", "0.0.2"
end


# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
