class AddTrainerToTrainees < ActiveRecord::Migration[5.0]
  def change
    add_reference :trainees, :trainer, foreign_key: true
  end
end
