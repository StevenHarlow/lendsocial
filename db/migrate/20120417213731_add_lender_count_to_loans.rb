class AddLenderCountToLoans < ActiveRecord::Migration
  def up
    change_column :loans, :total_committed, :decimal, :null => false, :default => 0.0
    add_column :loans, :lender_count, :integer, :null => false, :default => 0
  end

  def down
    change_column :loans, :total_committed, :decimal, :null => true, :default => nil
    remove_column :loans, :lender_count
  end
end
