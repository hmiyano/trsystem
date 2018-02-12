class AddSlackToTrainers < ActiveRecord::Migration[5.0]
  def change
    add_column :trainers, :slack, :string
  end
end
