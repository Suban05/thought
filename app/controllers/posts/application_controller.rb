# frozen_string_literal: true

class Posts::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :resource_post

  def resource_post
    @resource_post ||= Post.find(params[:post_id])
  end
end
