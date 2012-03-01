class ExtendBusiness < ActiveRecord::Migration
  def up
    change_table :businesses do |t|
      t.string :address
      t.string :phone
      t.references :business_industry
      t.change :description, :text
    end
  end

  def down
    change_table :businesses do |t|
      t.remove :address
      t.remove :phone
      t.remove_references :business_industry
      t.change :description, :string
    end
  end
end
