require 'test_helper'

class GameControllerTest < ActionDispatch::IntegrationTest
  
  test "should get index" do
    get '/'
    assert_response :success
  end

  test "should get new" do
    get '/game/new'
    assert_response :success
  end

end
