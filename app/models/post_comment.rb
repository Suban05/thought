class PostComment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_ancestry
end
