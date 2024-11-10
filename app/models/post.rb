class Post < ApplicationRecord
  belongs_to :creator, class_name: "User"
  belongs_to :category
  has_many :comments, class_name: "PostComment", dependent: :destroy
end
