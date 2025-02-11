# frozen_string_literal: true

require 'test_helper'

class Posts::LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:three)
    @like = post_likes(:one)
  end

  test 'should create like' do
    sign_in @user
    post post_likes_url(@post)
    assert_redirected_to post_url(@post)
    assert PostLike.find_by(post: @post, user_id: @user.id)
  end

  test 'should create post like only one time' do
    sign_in @user

    assert_difference('PostLike.count', 1) do
      3.times do
        post post_likes_url(@post)
      end
    end
    assert_redirected_to post_url(@post)
    assert PostLike.find_by(post: @post, user_id: @user.id)

    assert_difference('PostLike.count', 0) do
      post post_likes_url(@post)
    end
    assert_redirected_to post_url(@post)
  end

  test 'should not create like when user is unsigned' do
    assert_difference('PostLike.count', 0) do
      post post_likes_url(@post)
    end
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test 'should destroy like' do
    sign_in users(:one)
    delete post_like_url(@post, @like)
    assert_response :redirect
    assert_redirected_to post_url(@post)
    assert_nil PostLike.find_by(id: @like.id)
  end

  test 'should not destroy like when user is unsigned' do
    delete post_like_url(@post, @like)
    assert_response :redirect
    assert_redirected_to new_user_session_path
    assert PostLike.find_by(id: @like.id)
  end

  test 'should not destroy like of other user' do
    sign_in @user
    delete post_like_url(@post, @like)
    assert_response :redirect
    assert_redirected_to post_url(@like.post)
    assert PostLike.find_by(id: @like.id)
  end
end
