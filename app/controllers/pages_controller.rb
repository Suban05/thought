# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @posts = Post.all
  end
end
