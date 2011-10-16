class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.text :description
      t.boolean :public
      t.integer :owner_id
      
      t.timestamps
    end
  end
end
