class CreateBusinessConnections < ActiveRecord::Migration
  def change
    create_table :business_connections do |t|
      t.references :follower
      t.references :followed

      t.timestamps
    end
    add_index :business_connections, :follower_id
    add_index :business_connections, :followed_id
  end
end
