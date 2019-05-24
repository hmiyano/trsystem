class AddRpPg1acToChecklists < ActiveRecord::Migration[5.0]
  def change
    add_column :checklists, :rp_pg1ac, :boolean
  end
end
