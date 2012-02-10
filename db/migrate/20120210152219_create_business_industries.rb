class CreateBusinessIndustries < ActiveRecord::Migration
  def change
    create_table :business_industries do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
