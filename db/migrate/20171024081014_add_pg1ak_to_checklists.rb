class AddPg1akToChecklists < ActiveRecord::Migration[5.0]
  def change
    add_column :checklists, :pg1ak, :boolean, default: false, null: false
  end
end
