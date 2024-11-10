class CommentsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :set_post, only: %i[index create new]
  before_action :set_comment, only: %i[ show edit update destroy ]

  def index
    @comments = @post.comments.all
  end

  def new
    @comment = @post.comments.new
  end

  def edit
  end

  def create
    @comment = @post.comments.build(comments_params)
    @comment.user = current_user
    if @comment.save
      redirect_to comment_path(@comment), notice: "Comment was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comments_params)
      redirect_to comment_path(@comment), notice: "Comment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @comment.destroy!
    redirect_to posts_path, status: :see_other, notice: "Comment was successfully destroyed."
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = PostComment.find(params[:id])
  end

  def comments_params
    params.require(:post_comment).permit(:content)
  end
end
