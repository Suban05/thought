class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[create]

  def create
    @like = @post.likes.new
    @like.user = current_user
    @like.save
    redirect_to @post
  end

  def destroy
    like = PostLike.find(params[:id])
    post = like.post
    like.destroy!
    redirect_to post
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
