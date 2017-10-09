class CreateTrChecks < ActiveRecord::Migration[5.0]
  def change
    create_table :tr_checks do |t|
      t.references :trainer, foreign_key: true
      t.references :checklist, foreign_key: true

      t.timestamps
    end
  end
end
