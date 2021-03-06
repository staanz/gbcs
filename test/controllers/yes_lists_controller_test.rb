require 'test_helper'

class YesListsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get yes_lists_new_url
    assert_response :success
  end

  test "should get create" do
    get yes_lists_create_url
    assert_response :success
  end

  test "should get index" do
    get yes_lists_index_url
    assert_response :success
  end

  test "should get edit" do
    get yes_lists_edit_url
    assert_response :success
  end

  test "should get update" do
    get yes_lists_update_url
    assert_response :success
  end

  test "should get destroy" do
    get yes_lists_destroy_url
    assert_response :success
  end

end
