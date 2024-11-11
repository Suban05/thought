require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:three)
    @like = post_likes(:one)
  end

  test "should create like" do
    sign_in @user
    assert_difference("PostLike.count", 1) do
      post post_likes_url(@post)
    end
    assert_redirected_to post_url(@post)
  end

  test "should create post like only one time" do
    sign_in @user
    assert_difference("PostLike.count", 1) do
      3.times do
        post post_likes_url(@post)
      end
    end
    assert_redirected_to post_url(@post)
    assert_difference("PostLike.count", 0) do
      post post_likes_url(@post)
    end
    assert_redirected_to post_url(@post)
  end

  test "should not create like when user is unsigned" do
    assert_difference("PostLike.count", 0) do
      post post_likes_url(@post)
    end
    assert_redirected_to new_user_session_path
  end

  test "should destroy like" do
    sign_in users(:one)
    assert_difference("PostLike.count", -1) do
      delete like_url(@like)
    end

    assert_redirected_to post_url(@post)
  end

  test "should not destroy like when user is unsigned" do
    assert_difference("PostLike.count", 0) do
      delete like_url(@like)
    end
    assert_redirected_to new_user_session_path
  end

  test "should not destroy like of other user" do
    sign_in @user
    assert_difference("PostLike.count", 0) do
      delete like_url(@like)
    end
    assert_redirected_to post_url(@like.post)
  end
end
