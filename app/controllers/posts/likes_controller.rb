# frozen_string_literal: true

class Posts::LikesController < Posts::ApplicationController
  def create
    like = @resource_post.likes.new
    like.user = current_user
    like.save
    redirect_to @resource_post
  end

  def destroy
    like = PostLike.find(params[:id])
    if like.user == current_user
      like.destroy!
    end
    redirect_to @resource_post
  end
end
