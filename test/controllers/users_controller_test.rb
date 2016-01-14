require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'creates user' do
    post '/api/v1/users',
         { username: 'Testuser', email: 'test@gmail.com', password: 'password' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    user = JSON.parse(response.body)
    assert_equal user['username'], 'Testuser'
  end

  test 'checks username presence validation' do
    post '/api/v1/users',
         { username: '', email: 'test@gmail.com', password: 'password' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end


  test 'checks email presence validation' do
    post '/api/v1/users',
         { username: 'Testuser', email: '', password: 'password' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end


  test 'checks email format validation' do
    post '/api/v1/users',
         { username: 'Testuser', email: 'test.com', password: 'password' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end


  test 'checks password presence validation' do
    post '/api/v1/users',
         { username: 'Testuser', email: 'test@gmail.com', password: '' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end

  test 'user login' do 
    create_user_for_test
    post '/api/v1/auth/login',
         { username: 'Testuser', email: 'test@gmail.com', password: 'password' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end

  test 'user login fail for incorrect password' do 
    create_user_for_test
    post '/api/v1/auth/login',
         { username: 'Testuser', email: 'test@gmail.com', password: 'failedpassword' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    assert_equal 401, response.status
    assert_equal Mime::JSON, response.content_type
    error = JSON.parse(response.body)
    assert_equal error['error'], 'Invalid username or password'
  end

  test 'user login fail for incorrect username' do 
    create_user_for_test
    post '/api/v1/auth/login',
         { username: 'faileduser', email: 'test@gmail.com', password: 'password' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    error = JSON.parse(response.body)
  end

  test 'user login fail for incorrect email' do 
    create_user_for_test
    post '/api/v1/auth/login',
         { username: 'Testuser', email: 'failed@gmail.com', password: 'password' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    assert_equal 401, response.status
    assert_equal Mime::JSON, response.content_type
    error = JSON.parse(response.body)
   
    assert_equal error['error'], 'Invalid username or password'
  end

  test 'user logout' do 
    token = login_for_test
    get '/api/v1/auth/logout', {},
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s,
         'Authorization' => 'Token #{token}'
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end

  test 'token validation for user logout' do 
    token = login_for_test
    get '/api/v1/auth/logout', {},
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s,
         'Authorization' => ''
    assert_equal 401, response.status
    error = response.body
    assert_equal error, "HTTP Token: Access denied.\n" 
  end
end
