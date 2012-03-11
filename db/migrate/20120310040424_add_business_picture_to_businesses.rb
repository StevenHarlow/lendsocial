class AddBusinessPictureToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :business_picture, :string
  end
end
