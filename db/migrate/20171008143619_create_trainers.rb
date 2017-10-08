class CreateTrainers < ActiveRecord::Migration[5.0]
  def change
    create_table :trainers do |t|
      t.string :name
      t.string :email
      t.string :branch
      t.string :password_digest

      t.timestamps
    end
  end
end
