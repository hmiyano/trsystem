class AddEnableToChecklists < ActiveRecord::Migration[5.0]
  def change
    add_column :checklists, :enable, :boolean
  end
end
