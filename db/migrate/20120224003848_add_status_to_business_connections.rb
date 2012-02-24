class AddStatusToBusinessConnections < ActiveRecord::Migration
  def change
    add_column :business_connections, :status, :string
  end
end
