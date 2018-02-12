class AddSlackToTrainees < ActiveRecord::Migration[5.0]
  def change
    add_column :trainees, :slack, :string
  end
end
