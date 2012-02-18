class DropMessageTypes < ActiveRecord::Migration
  def up
    drop_table :message_types
  end

  def down
    create_table :message_types do |t|
      t.string :description
      t.timestamps
    end
  end
end