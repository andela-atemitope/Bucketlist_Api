require "codeclimate-test-reporter"
require 'simplecov'
CodeClimate::TestReporter.start
SimpleCov.start
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
DatabaseCleaner.strategy = :transaction

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all CodeClimate::TestReporter.configure do |config|
  config.logger.level = Logger::WARN


CodeClimate::TestReporter.configure do |config|
  config.logger.level = Logger::WARN
end

CodeClimate::TestReporter.start
  def create_user_for_test
    post "/api/v1/users",
       { username: "TestUser", email: "test@gmail.com", password: "password" }.to_json,
       "Accept" => Mime::JSON, "Content-Type" => Mime::JSON.to_s
  end
  # Add more helper methods to be used by all tests here...

  def login_for_test
    create_user_for_test
    post "/api/v1/auth/login",
           { username: "TestUser", email: "test@gmail.com", password: "password" }.to_json,
           "Accept" => Mime::JSON, 
           "Content-Type" => Mime::JSON.to_s
    token = JSON.parse(response.body)
    token["auth_token"]
  end


    def create_bucketlist_for_test
      @auth_token = login_for_test
      Bucketlist.delete_all
      9.times do
        post "/api/v1/bucketlists/",
             { name: "testlist" }.to_json,
             "Accept" => Mime::JSON,
             "Content-Type" => Mime::JSON.to_s,
             "Authorization" => "Token #{@auth_token}"
      end
    end

    def create_items_for_test
        create_bucketlist_for_test
      9.times do
        post "/api/v1/bucketlists/980190965/items",
             { name: "testitem" }.to_json,
             "Accept" => Mime::JSON, "Content-Type" => Mime::JSON.to_s,
              "Authorization" => "Token #{@auth_token}"
      end
    end


  def create_second_user_for_test
    post "/api/v1/users",
       { username: "SecondTestUser", email: "Secondtest@gmail.com", password: "secondpassword" }.to_json,
       "Accept" => Mime::JSON, "Content-Type" => Mime::JSON.to_s
  end
  # Add more helper methods to be used by all tests here...

  def login_for_second_test
    create_user_for_test
    post "/api/v1/auth/login",
           { username: "SecondTestUser", email: "Secondtest@gmail.com", password: "secondpassword" }.to_json,
           "Accept" => Mime::JSON, 
           "Content-Type" => Mime::JSON.to_s
    token = JSON.parse(response.body)
    token["auth_token"]
  end


  def create_second_bucketlist_for_test
    @second_auth_token = login_for_second_test
    9.times do
      post "/api/v1/bucketlists/",
           { name: "Secondtestlist" }.to_json,
           "Accept" => Mime::JSON,
           "Content-Type" => Mime::JSON.to_s,
           "Authorization" => "Token #{@second_auth_token}"
    end
  end
end
