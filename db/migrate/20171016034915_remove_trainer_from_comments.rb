class RemoveTrainerFromComments < ActiveRecord::Migration[5.0]
  def change
    remove_reference :comments, :trainer, foreign_key: true
  end
end
