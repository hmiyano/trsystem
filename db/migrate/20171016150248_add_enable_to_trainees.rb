class AddEnableToTrainees < ActiveRecord::Migration[5.0]
  def change
    add_column :trainees, :enable, :boolean, default: false, null: false
  end
end
