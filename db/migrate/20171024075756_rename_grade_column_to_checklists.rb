class RenameGradeColumnToChecklists < ActiveRecord::Migration[5.0]
  def change
    rename_column :checklists, :grade, :pg1ac
  end
end
