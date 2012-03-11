class DeviseCreateUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.change :email, :string, :null => false, :default => ""
      t.rename :crypted_password, :encrypted_password
      t.change :encrypted_password, :string, :null => false, :default => ""
      t.remove :persistence_token
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at
    end
    
    add_index :users, :email, :unique => true
    add_index :users, :reset_password_token, :unique => true
  end
end
