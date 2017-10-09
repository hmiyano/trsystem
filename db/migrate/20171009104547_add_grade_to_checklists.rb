class AddGradeToChecklists < ActiveRecord::Migration[5.0]
  def change
    add_column :checklists, :grade, :string
  end
end
