class AddRpPg1akToChecklists < ActiveRecord::Migration[5.0]
  def change
    add_column :checklists, :rp_pg1ak, :boolean
  end
end
