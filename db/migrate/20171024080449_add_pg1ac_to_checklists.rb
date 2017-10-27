class AddPg1acToChecklists < ActiveRecord::Migration[5.0]
  def change
    add_column :checklists, :pg1ac, :boolean, default: false, null: false
  end
end
