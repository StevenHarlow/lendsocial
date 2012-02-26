class ExtendBusinessConnections < ActiveRecord::Migration
  def change
    add_column :business_connections, :initiator_id, :integer
    add_column :business_connections, :response_at, :datetime
    add_column :business_connections, :viewed_at, :datetime
    add_column :business_connections, :message, :text
  end
end
