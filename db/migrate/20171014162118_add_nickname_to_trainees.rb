class AddNicknameToTrainees < ActiveRecord::Migration[5.0]
  def change
    add_column :trainees, :nickname, :string
  end
end
