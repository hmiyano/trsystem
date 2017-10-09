class CreateTeChecks < ActiveRecord::Migration[5.0]
  def change
    create_table :te_checks do |t|
      t.string :type
      t.references :trainee, foreign_key: true
      t.references :checklist, foreign_key: true

      t.timestamps
      
      t.index [:trainee_id, :checklist_id, :type], unique: true
    end
  end
end
