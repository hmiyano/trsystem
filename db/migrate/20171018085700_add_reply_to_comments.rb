class AddReplyToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :reply, :string
  end
end
