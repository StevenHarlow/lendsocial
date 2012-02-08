class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :message_type
      t.references :author
      t.references :posted_to, :polymorphic => true
      t.references :related_message
      t.string :text

      t.timestamps
    end
    add_index :messages, :author_id
    add_index :messages, :posted_to_id
    add_index :messages, :related_message_id
  end
end
