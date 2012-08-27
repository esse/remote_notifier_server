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
  
  test "should create notification" do
    authorize 'Rainbow', 'Dash'
    post '/api/v1/notifications.json', "notification" => { :message => 'error', :msg_class => 'Runtime error', :backtrace => 'stacktrace' }
    assert_equal 201, last_response.status
    assert_equal 1, Notification.count
  end

  test "should create ancestry inside notification" do
    authorize 'Rainbow', 'Dash'
    post '/api/v1/notifications.json', "notification" => { :message => 'error', :msg_class => 'Runtime error', :backtrace => 'stacktrace' }
    assert_equal 201, last_response.status
    assert_equal 1, Notification.count
    assert Notification.first.is_root?
    post '/api/v1/notifications.json', "notification" => { :message => 'error', :msg_class => 'Runtime error', :backtrace => 'stacktrace' }
    assert_equal 201, last_response.status
    assert_equal 2, Notification.count
    assert !Notification.last.is_root?
    assert_equal 1, Notification.first.children.count
  end
  
  test "should reset solved status when creating children inside notification" do
    authorize 'Rainbow', 'Dash'
    post '/api/v1/notifications.json', "notification" => { :message => 'error', :msg_class => 'Runtime error', :backtrace => 'stacktrace' }
    assert_equal 201, last_response.status
    assert_equal 1, Notification.count
    assert Notification.first.is_root?
    assert !Notification.first.solved?
    Notification.first.update_attribute(:solved, true)
    assert Notification.first.solved?
    post '/api/v1/notifications.json', "notification" => { :message => 'error', :msg_class => 'Runtime error', :backtrace => 'stacktrace' }
    assert_equal 201, last_response.status
    assert_equal 2, Notification.count
    assert !Notification.last.is_root?
    assert_equal 1, Notification.first.children.count
    assert !Notification.first.solved?
  end

end
