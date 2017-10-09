class AddChapterToChecklists < ActiveRecord::Migration[5.0]
  def change
    add_column :checklists, :chapter, :string
  end
end
