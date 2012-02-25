class ExtendBusinessConnections < ActiveRecord::Migration
  def change
    add_column :business_connections, :response_at, :datetime
    add_column :business_connections, :message, :text
  end
end
