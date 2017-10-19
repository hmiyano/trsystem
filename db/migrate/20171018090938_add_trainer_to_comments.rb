class AddTrainerToComments < ActiveRecord::Migration[5.0]
  def change
    add_reference :comments, :trainer, foreign_key: true
  end
end
