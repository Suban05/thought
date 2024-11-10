class RenameUserIdToCreatorIdInPosts < ActiveRecord::Migration[7.2]
  def change
    rename_column :posts, :user_id, :creator_id
  end
end
