require 'test_helper'

class UserRelationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_relations_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_relations_destroy_url
    assert_response :success
  end

end
