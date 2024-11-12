# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:one)
    @comment = post_comments(:one)
  end

  test 'should create comment' do
    sign_in @user
    assert_difference('PostComment.count', 1) do
      post post_comments_url(@post), params: { post_comment: { content: @comment.content } }
    end
    assert_redirected_to post_url(@post)
  end

  test 'should create child comment' do
    sign_in @user
    assert_difference('PostComment.count', 1) do
      post post_comments_url(@post), params: { post_comment: { content: 'some text', parent_id: @comment.id } }
    end
    assert_redirected_to post_url(@post)
  end

  test 'should not create comment when user is unsigned' do
    assert_difference('PostComment.count', 0) do
      post post_comments_url(@post), params: { post_comment: { content: @comment.content } }
    end
    assert_redirected_to new_user_session_path
  end

  test 'should destroy comment' do
    sign_in @user
    assert_difference('PostComment.count', -1) do
      delete post_comment_url(@post, @comment)
    end

    assert_redirected_to post_url(@post)
  end

  test 'should not destroy comment when user is unsigned' do
    assert_difference('PostComment.count', 0) do
      delete post_comment_url(@post, @comment)
    end
    assert_redirected_to new_user_session_path
  end
end
