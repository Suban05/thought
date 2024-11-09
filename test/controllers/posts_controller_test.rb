require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:john)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get new_post_url
    assert_response :success
  end

  test "should not get new when user is unsigned" do
    get new_post_url
    assert_redirected_to new_user_session_path
  end

  test "should create post" do
    sign_in @user
    assert_difference("Post.count", 1) do
      post posts_url, params: { post: { body: @post.body, category_id: @post.category_id, title: @post.title, user_id: @post.user_id } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should not create post when user is unsigned" do
    assert_difference("Post.count", 0) do
      post posts_url, params: { post: { body: @post.body, category_id: @post.category_id, title: @post.title, user_id: @post.user_id } }
    end
    assert_redirected_to new_user_session_path
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get edit_post_url(@post)
    assert_response :success
  end

  test "should not get edit when user is unsigned" do
    get edit_post_url(@post)
    assert_redirected_to new_user_session_path
  end

  test "should update post" do
    sign_in @user
    patch post_url(@post), params: { post: { body: @post.body, category_id: @post.category_id, title: @post.title, user_id: @post.user_id } }
    assert_redirected_to post_url(@post)
  end

  test "should not update post when user is unsigned" do
    patch post_url(@post), params: { post: { body: @post.body, category_id: @post.category_id, title: @post.title, user_id: @post.user_id } }
    assert_redirected_to new_user_session_path
  end

  test "should destroy post" do
    sign_in @user
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end

  test "should not destroy post when user is unsigned" do
    assert_difference("Post.count", 0) do
      delete post_url(@post)
    end
    assert_redirected_to new_user_session_path
  end
end
