# frozen_string_literal: true

json.extract! post, :id, :title, :body, :creator_id, :category_id, :created_at, :updated_at
json.url post_url(post, format: :json)
