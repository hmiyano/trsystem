class AddPg1akChecklistToTrChecks < ActiveRecord::Migration[5.0]
  def change
    add_reference :tr_checks, :pg1ak_checklist, foreign_key: true
  end
end
