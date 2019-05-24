class AddRpPg1acToTrainees < ActiveRecord::Migration[5.0]
  def change
    add_column :trainees, :rp_pg1ac, :boolean
  end
end
