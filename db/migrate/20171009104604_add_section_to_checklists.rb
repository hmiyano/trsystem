class AddSectionToChecklists < ActiveRecord::Migration[5.0]
  def change
    add_column :checklists, :section, :string
  end
end
