class AddRpPg1akToTrainees < ActiveRecord::Migration[5.0]
  def change
    add_column :trainees, :rp_pg1ak, :boolean
  end
end
