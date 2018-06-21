require 'test_helper'

class TagGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tag_group = tag_groups(:one)
  end

  test "should get index" do
    get tag_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_tag_group_url
    assert_response :success
  end

  test "should create tag_group" do
    assert_difference('TagGroup.count') do
      post tag_groups_url, params: { tag_group: { name: @tag_group.name } }
    end

    assert_redirected_to tag_group_url(TagGroup.last)
  end

  test "should show tag_group" do
    get tag_group_url(@tag_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_tag_group_url(@tag_group)
    assert_response :success
  end

  test "should update tag_group" do
    patch tag_group_url(@tag_group), params: { tag_group: { name: @tag_group.name } }
    assert_redirected_to tag_group_url(@tag_group)
  end

  test "should destroy tag_group" do
    assert_difference('TagGroup.count', -1) do
      delete tag_group_url(@tag_group)
    end

    assert_redirected_to tag_groups_url
  end
end
