require 'test_helper'

class GameControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get game_index_url
    assert_response :success
  end

  test "should get new" do
    get game_new_url
    assert_response :success
  end

end
