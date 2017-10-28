class AddCategoryToChecklists < ActiveRecord::Migration[5.0]
  def change
    add_column :checklists, :category, :string
    add_column :checklists, :pg1bc, :boolean, default: false, null: false
    add_column :checklists, :pg1bk, :boolean, default: false, null: false
    add_column :checklists, :pg2ac, :boolean, default: false, null: false
    add_column :checklists, :pg2ak, :boolean, default: false, null: false
    add_column :checklists, :pg2bc, :boolean, default: false, null: false
    add_column :checklists, :pg2bk, :boolean, default: false, null: false
    add_column :checklists, :pg2cc, :boolean, default: false, null: false
    add_column :checklists, :pg2ck, :boolean, default: false, null: false
    add_column :checklists, :pg3a, :boolean, default: false, null: false
    add_column :checklists, :pg3b, :boolean, default: false, null: false
    add_column :checklists, :pg3c, :boolean, default: false, null: false
    add_column :checklists, :g1a, :boolean, default: false, null: false
    add_column :checklists, :g1b, :boolean, default: false, null: false
    add_column :checklists, :g1c, :boolean, default: false, null: false
    add_column :checklists, :g1d, :boolean, default: false, null: false
    add_column :checklists, :g2a, :boolean, default: false, null: false
    add_column :checklists, :g2b, :boolean, default: false, null: false
    add_column :checklists, :g2c, :boolean, default: false, null: false
    add_column :checklists, :g2d, :boolean, default: false, null: false
  end
end
