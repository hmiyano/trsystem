class AddGradeToTrainees < ActiveRecord::Migration[5.0]
  def change
    add_column :trainees, :grade, :string
  end
end
