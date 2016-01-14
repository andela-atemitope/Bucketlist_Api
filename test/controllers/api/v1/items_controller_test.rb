require 'test_helper'

class Api::V1::ItemsControllerTest < ActionDispatch::IntegrationTest
  test 'creates new item' do
    create_bucketlist_for_test
    post '/api/v1/bucketlists/1/items',
         { name: 'testitem' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s,
          'Authorization' => "Token #{@auth_token}"
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
  end


  test 'validates item name presence' do
    token = login_for_test
    post '/api/v1/bucketlists/1/items',
         { name: '' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s,
          'Authorization' => "Token #{token}"
    assert_equal 404, response.status
  end

  test 'validates token presence for item' do
    token = login_for_test
    post '/api/v1/bucketlists/1/items',
         { name: '' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s,
          'Authorization' => ''
    assert_equal 401, response.status
  end

  test 'fetches the item with the specific id ' do
    create_items_for_test
    get '/api/v1/bucketlists/1', {},
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s,
          'Authorization' => "Token #{@auth_token}"

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    error = JSON.parse(response.body)
  end
end


 
