# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:john)
  end

  test 'should get new' do
    sign_in @user
    get new_post_url
    assert_response :success
  end

  test 'should not get new when user is unsigned' do
    get new_post_url
    assert_redirected_to new_user_session_path
  end

  test 'should create post' do
    sign_in @user
    body = 'body'
    title = 'create a post from test'
    post posts_url, params: { post: { body:, category_id: @post.category_id, title: } }
    assert_response :redirect

    created_post = Post.find_by(
      body:,
      category_id: @post.category_id,
      creator_id: @user.id,
      title:
    )
    assert(created_post)
    assert_redirected_to post_url(created_post)
  end

  test 'should not create post when user is unsigned' do
    body = 'body'
    title = 'unsuccessful creation'
    post posts_url, params: { post: { body: @post.body, category_id: @post.category_id, title: @post.title, creator_id: @post.creator_id } }
    assert_redirected_to new_user_session_path
    created_post = Post.find_by(
      body:,
      category_id: @post.category_id,
      title:
    )
    assert_nil(created_post)
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end

  test 'should destroy post' do
    sign_in @user
    delete post_url(@post)
    assert_response :redirect
    assert_redirected_to posts_url
    assert_nil Post.find_by(id: @post.id)
  end

  test 'should not destroy post when user is unsigned' do
    delete post_url(@post)
    assert_redirected_to new_user_session_path
    assert Post.find_by(id: @post.id)
  end

  test 'should get home from index' do
    get root_path
    assert_response :success
  end
end
