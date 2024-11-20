# frozen_string_literal: true

require 'test_helper'

class Posts::CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:one)
    @comment = post_comments(:one)
  end

  test 'should create comment' do
    sign_in @user
    post post_comments_url(@post), params: { post_comment: { content: @comment.content } }
    assert_response :redirect
    assert_redirected_to post_url(@post)
    assert PostComment.find_by(content: @comment.content, user_id: @user.id)
  end

  test 'should not create empty comment' do
    sign_in @user
    assert_difference('PostComment.count', 0) do
      post post_comments_url(@post), params: { post_comment: { content: '' } }
    end
    assert_response :redirect
    assert_redirected_to post_url(@post)
    assert_nil PostComment.find_by(content: '', user_id: @user.id)
  end

  test 'should create child comment' do
    sign_in @user
    content = 'some text'
    post post_comments_url(@post), params: { post_comment: { content:, parent_id: @comment.id } }
    assert_response :redirect
    assert_redirected_to post_url(@post)
    assert PostComment.find_by(content:, user_id: @user.id, ancestry: "/#{@comment.id}/")
  end

  test 'should not create comment when user is unsigned' do
    assert_difference('PostComment.count', 0) do
      post post_comments_url(@post), params: { post_comment: { content: @comment.content } }
    end
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test 'should destroy comment' do
    sign_in @user
    delete post_comment_url(@post, @comment)
    assert_response :redirect
    assert_redirected_to post_url(@post)
    assert_nil PostComment.find_by(id: @comment.id)
  end

  test 'should not destroy comment when user is unsigned' do
    delete post_comment_url(@post, @comment)
    assert_response :redirect
    assert_redirected_to new_user_session_path
    assert PostComment.find_by(id: @comment.id)
  end
end
