class AddGradeToTrainers < ActiveRecord::Migration[5.0]
  def change
    add_column :trainers, :grade, :string
  end
end
