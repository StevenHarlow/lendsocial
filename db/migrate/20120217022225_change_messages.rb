class ChangeMessages < ActiveRecord::Migration
  def up
    change_table :messages do |t|
      t.remove_references :message_type
      t.references :by_business
      t.index :by_business_id
      t.change :text, :text
    end
  end

  def down
    change_table :messages do |t|
      t.references :message_type
      t.remove_references :by_business
      t.change :text, :string
    end
  end
end
