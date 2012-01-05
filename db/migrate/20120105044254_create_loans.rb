class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.references :business
      t.references :user
      t.datetime :requestDate
      t.decimal :amountRequested
      t.datetime :fundingDeadline
      t.references :loan_purpose
      t.datetime :fundedDate
      t.decimal :totalCommitted
      t.string :description
      t.string :benefits
      t.string :thankYouMessage
      t.datetime :publishedDate

      t.timestamps
    end
    add_index :loans, :business_id
    add_index :loans, :user_id
    add_index :loans, :loan_purpose_id
  end
end
