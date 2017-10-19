class RemoveEncryptedPasswordFromTrainees < ActiveRecord::Migration[5.0]
  def change
    remove_column :trainees, :encrypted_password, :string
  end
end
