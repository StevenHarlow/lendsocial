class ExtendBusiness2 < ActiveRecord::Migration
  def up
    change_table :businesses do |t|
      t.string :city
      t.string :state
      t.string :zipcode
      t.datetime :business_started
      t.remove_references :business_industry
    end
    
    drop_table :business_industries
  end

  def down
    change_table :businesses do |t|
      t.remove :city
      t.remove :state
      t.remove :zipcode
      t.remove :business_started
      t.references :business_industry
    end

    create_table :business_industries do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
