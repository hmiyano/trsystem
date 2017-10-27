class RemovePg1acToChecklists < ActiveRecord::Migration[5.0]
  def change
    remove_column :checklists, :pg1ac, :string
  end
end
