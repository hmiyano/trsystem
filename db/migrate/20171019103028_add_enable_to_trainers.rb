class AddEnableToTrainers < ActiveRecord::Migration[5.0]
  def change
    add_column :trainers, :enable, :boolean
  end
end
