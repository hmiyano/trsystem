class AddGradeToTrainees < ActiveRecord::Migration[5.0]
  def change
    add_column :trainees, :pg1ac, :boolean, default: false, null: false
    add_column :trainees, :pg1ak, :boolean, default: false, null: false
    add_column :trainees, :pg1bc, :boolean, default: false, null: false
    add_column :trainees, :pg1bk, :boolean, default: false, null: false
    add_column :trainees, :pg2ac, :boolean, default: false, null: false
    add_column :trainees, :pg2ak, :boolean, default: false, null: false
    add_column :trainees, :pg2bc, :boolean, default: false, null: false
    add_column :trainees, :pg2bk, :boolean, default: false, null: false
    add_column :trainees, :pg2cc, :boolean, default: false, null: false
    add_column :trainees, :pg2ck, :boolean, default: false, null: false
    add_column :trainees, :pg3a, :boolean, default: false, null: false
    add_column :trainees, :pg3b, :boolean, default: false, null: false
    add_column :trainees, :pg3c, :boolean, default: false, null: false
    add_column :trainees, :g1a, :boolean, default: false, null: false
    add_column :trainees, :g1b, :boolean, default: false, null: false
    add_column :trainees, :g1c, :boolean, default: false, null: false
    add_column :trainees, :g1d, :boolean, default: false, null: false
    add_column :trainees, :g2a, :boolean, default: false, null: false
    add_column :trainees, :g2b, :boolean, default: false, null: false
    add_column :trainees, :g2c, :boolean, default: false, null: false
    add_column :trainees, :g2d, :boolean, default: false, null: false
  end
end
