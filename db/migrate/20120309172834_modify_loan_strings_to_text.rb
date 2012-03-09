class ModifyLoanStringsToText < ActiveRecord::Migration
  def up
    change_table :loans do |t|
      t.change :description, :text
      t.change :benefits, :text
      t.change :thank_you_message, :text
    end
  end

  def down
    change_table :loans do |t|
      t.change :description, :string
      t.change :benefits, :string
      t.change :thank_you_message, :string
    end
  end
end
