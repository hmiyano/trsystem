class AddPg1akChecklistToTeChecks < ActiveRecord::Migration[5.0]
  def change
    add_reference :te_checks, :pg1ak_checklist, foreign_key: true
  end
end
