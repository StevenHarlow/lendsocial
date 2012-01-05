class CreateLoanPurposes < ActiveRecord::Migration
  def change
    create_table :loan_purposes do |t|
      t.string :description

      t.timestamps
    end
  end
end
