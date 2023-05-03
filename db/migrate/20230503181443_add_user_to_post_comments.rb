class AddUserToPostComments < ActiveRecord::Migration[7.0]
  def change
    add_reference :post_comments, :user, null: false, foreign_key: true
  end
end
