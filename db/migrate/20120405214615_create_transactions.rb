class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :tx_type
      t.decimal :amount
      t.references :user
      t.references :loan
      t.references :business

      t.timestamps
    end
    add_index :transactions, [:user_id, :tx_type]
    add_index :transactions, [:loan_id, :tx_type]
    add_index :transactions, [:business_id, :tx_type]
  end
end
