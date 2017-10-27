class CreatePg1akChecklists < ActiveRecord::Migration[5.0]
  def change
    create_table :pg1ak_checklists do |t|
      t.references :admin, foreign_key: true
      t.string :chapter
      t.string :section
      t.string :content
      t.boolean :enable

      t.timestamps
    end
  end
end
