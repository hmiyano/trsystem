class AddAdminToChecklists < ActiveRecord::Migration[5.0]
  def change
    add_reference :checklists, :admin, foreign_key: true
  end
end
