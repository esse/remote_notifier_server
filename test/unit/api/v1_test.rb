require File.expand_path('../../../test_helper', __FILE__)


class V1Test < ActiveSupport::TestCase
  
  def app
    Server::Application
  end
  
  include Rack::Test::Methods
  
  setup do
    @client = Client.create!(:token => 'Rainbow', :secret => 'Dash', :name => 'c')
  end

  test "should raise an error when there is no authorisation" do
    get "/api/v1/notifications.json"
    assert_equal 401, last_response.status
    assert_equal "HTTP Basic: Access denied.\n", last_response.body
  end
  
  test "should raise an error when there is bad authorisation" do
    authorize 'Pinkie', 'Pie'
    get "/api/v1/notifications.json"
    assert_equal 401, last_response.status
    assert_equal "HTTP Basic: Access denied.\n", last_response.body
  end
  
  test "should not raise an error when there is authorisation" do
    authorize 'Rainbow', 'Dash'
    get "/api/v1/notifications.json"
    assert_equal 200, last_response.status
    assert_equal "[]", last_response.body
  end
  
  test "should create proper ancestry when creating same as existing" do
    
  end

end
