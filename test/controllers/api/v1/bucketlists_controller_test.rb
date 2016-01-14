require "test_helper"

class Api::V1::BucketlistsControllerTest < ActionDispatch::IntegrationTest

  test "creates new bucketlist" do

    token = login_for_test
    post "/api/v1/bucketlists",
         { name: "testbucketlist" }.to_json,
         "Accept" => Mime::JSON, "Content-Type" => Mime::JSON.to_s,
          "Authorization" => "Token #{token}"
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
  end

  test "validates bucketlist name presence" do
    token = login_for_test
    post "/api/v1/bucketlists",
         { name: "" }.to_json,
         "Accept" => Mime::JSON, "Content-Type" => Mime::JSON.to_s,
          "Authorization" => "Token #{token}"
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    status = JSON.parse(response.body)
    assert_equal status[0],  "Name can't be blank"
  end

  test "validates token presence" do
    token = login_for_test
    post "/api/v1/bucketlists",
         { name: "" }.to_json,
         "Accept" => Mime::JSON, "Content-Type" => Mime::JSON.to_s,
          "Authorization" => ""
    assert_equal 401, response.status
  end

  test "checks for incorrect bucket name input" do
    create_bucketlist_for_test
    get "/api/v1/bucketlists",
         { name: "testbucketlist" }.to_json,
         "Accept" => Mime::JSON, "Content-Type" => Mime::JSON.to_s,
          "Authorization" => "Token #{@auth_token}"
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end

  test "fetches all the bucketlists" do
    create_bucketlist_for_test
    get "/api/v1/bucketlists", {},
         "Accept" => Mime::JSON, "Content-Type" => Mime::JSON.to_s,
          "Authorization" => "Token #{@auth_token}"
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end


  test "fetches bucketlist by id" do
    create_bucketlist_for_test
    get "/api/v1/bucketlists/1", {},
        "Accept" => Mime::JSON,
        "Content-Type" => Mime::JSON.to_s, "Authorization" => "Token #{@auth_token}"
        # require "pry"; binding.pry
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    bucketlist = JSON.parse(response.body)
    assert_equal bucketlist["name"], "Testlist"
  end

  test "searching for bucketlist " do
    create_bucketlist_for_test
    get "/api/v1/bucketlists/", {q: "testlist"},
        "Accept" => Mime::JSON,
        "Content-Type" => Mime::JSON.to_s, "Authorization" => "Token #{@auth_token}"
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    bucketlist = JSON.parse(response.body)
  end

  test "Paginates users bucketlists and others public bucketlists" do
    create_bucketlist_for_test
    get "/api/v1/bucketlists", { page: 3, limit: 2 },
        "Accept" => Mime::JSON,
        "Content-Type" => Mime::JSON.to_s, "Authorization" => "Token #{@auth_token}"
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    bucketlist = JSON.parse(response.body)
    assert_equal bucketlist.count, 2
  end

  test "restricts search for unauthorized bucketlist" do
    create_bucketlist_for_test
    create_second_bucketlist_for_test
    get "/api/v1/bucketlists/980190966", {},
        "Accept" => Mime::JSON,
        "Content-Type" => Mime::JSON.to_s, "Authorization" => "Token #{@second_auth_token}"
    assert_equal 401, response.status
    bucketlist = response.body
    assert_equal bucketlist,  "HTTP Token: Access denied.\n"
  end
 
  test "deletes bucketlist" do
    create_bucketlist_for_test
    delete "/api/v1/bucketlists/980190966", {},
           "Accept" => Mime::JSON,
           "Content-Type" => Mime::JSON.to_s, "Authorization" => "Token #{@auth_token}"
    assert_equal 303, response.status
    assert_equal Mime::JSON, response.content_type
  end

 test "updates bucketlist" do
    create_bucketlist_for_test
    patch "/api/v1/bucketlists/1", { name: "editedtestbucketlist" }.to_json,
          "Accept" => Mime::JSON,
          "Content-Type" => Mime::JSON.to_s, "Authorization" => "Token #{@auth_token}"
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    bucketlist = JSON.parse(response.body)
    assert_equal bucketlist["name"], "Editedtestbucketlist"
  end
end
