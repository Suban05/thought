# frozen_string_literal: true

class Posts::CommentsController < Posts::ApplicationController
  def create
    comment = @resource_post.comments.build(comments_params)
    comment.user = current_user
    if comment.save
      redirect_to post_path(@resource_post), notice: t('.create.success')
    else
      redirect_to post_path(@resource_post)
    end
  end

  def destroy
    PostComment.find(params[:id]).destroy!
    redirect_to post_path(@resource_post), status: :see_other, notice: t('.destroy.success')
  end

  private

  def comments_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
