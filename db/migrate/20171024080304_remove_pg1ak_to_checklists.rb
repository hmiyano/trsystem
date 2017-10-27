class RemovePg1akToChecklists < ActiveRecord::Migration[5.0]
  def change
    remove_column :checklists, :pg1ak, :string
  end
end
