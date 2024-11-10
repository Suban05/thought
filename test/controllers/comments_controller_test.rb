require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:one)
    @user = users(:one)
    @comment = post_comments(:one)
  end

  test "should get index" do
    get post_comments_url(@post)
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get new_post_comment_url(@post)
    assert_response :success
  end

  test "should not get new when user is unsigned" do
    get new_post_comment_url(@post)
    assert_redirected_to new_user_session_path
  end

  test "should create comment" do
    sign_in @user
    assert_difference("PostComment.count", 1) do
      post post_comments_url(@post), params: { post_comment: { content: @comment.content } }
    end
    assert_redirected_to post_url(@post)
  end

  test "should create child comment" do
    sign_in @user
    assert_difference("PostComment.count", 1) do
      post post_comments_url(@post), params: { post_comment: { content: "some text", parent_id: @comment.id } }
    end
    assert_redirected_to post_url(@post)
  end

  test "should not create comment when user is unsigned" do
    assert_difference("PostComment.count", 0) do
      post post_comments_url(@post), params: { post_comment: { content: @comment.content } }
    end
    assert_redirected_to new_user_session_path
  end

  test "should show comment" do
    get comment_url(@comment)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get edit_comment_url(@comment)
    assert_response :success
  end

  test "should not get edit when user is unsigned" do
    get edit_comment_url(@comment)
    assert_redirected_to new_user_session_path
  end

  test "should update post" do
    sign_in @user
    patch comment_url(@comment), params: { post_comment: { content: "hello" } }
    @comment.reload
    assert { "hello" == @comment.content }
    assert_redirected_to post_url(@comment.post)
  end

  test "should not update post when user is unsigned" do
    patch post_url(@post), params: { post: { body: @post.body, category_id: @post.category_id, title: @post.title, creator_id: @post.creator_id } }
    assert_redirected_to new_user_session_path
  end

  test "should destroy post" do
    sign_in @user
    assert_difference("PostComment.count", -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to post_url(@post)
  end

  test "should not destroy post when user is unsigned" do
    assert_difference("PostComment.count", 0) do
      delete post_url(@comment)
    end
    assert_redirected_to new_user_session_path
  end
end
