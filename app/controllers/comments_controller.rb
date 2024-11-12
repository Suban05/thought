# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[create]
  before_action :set_comment, only: %i[destroy]

  def create
    @comment = @post.comments.build(comments_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post), notice: t('.create.success')
    else
      render post_path(@post)
    end
  end

  def destroy
    @comment.destroy!
    post = @comment.post
    redirect_to post_path(post), status: :see_other, notice: t('.destroy.success')
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = PostComment.find(params[:id])
  end

  def comments_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
