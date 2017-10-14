class AddNicknameToTrainers < ActiveRecord::Migration[5.0]
  def change
    add_column :trainers, :nickname, :string
  end
end
