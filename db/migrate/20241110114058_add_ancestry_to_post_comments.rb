class AddAncestryToPostComments < ActiveRecord::Migration[7.2]
  def change
    change_table(:post_comments) do |t|
      t.string :ancestry, null: false, default: "/"
      t.index :ancestry
    end
  end
end
