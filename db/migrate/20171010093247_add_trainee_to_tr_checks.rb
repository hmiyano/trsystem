class AddTraineeToTrChecks < ActiveRecord::Migration[5.0]
  def change
    add_reference :tr_checks, :trainee, foreign_key: true
  end
end
