class CreateProfileActivities < ActiveRecord::Migration
  def change
    create_table :profile_activities do |t|
      t.integer :profile_id
      t.integer :actor_id
      t.string  :name
      t.string  :detail
      t.timestamps
    end
  end
end
