class CreateUserBusinesses < ActiveRecord::Migration
  def change
    create_table :user_businesses do |t|
      t.references :user
      t.references :business
      t.string :role

      t.timestamps
    end
    add_index :user_businesses, :user_id
    add_index :user_businesses, :business_id
  end
end
