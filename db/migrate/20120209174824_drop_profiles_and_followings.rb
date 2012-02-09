class DropProfilesAndFollowings < ActiveRecord::Migration

  def up
    drop_table :profile_activities
    drop_table :followings
    drop_table :profiles
  end

  def down
    create_table :profiles do |t|
      t.string :name
      t.text :description
      t.boolean :public
      t.integer :owner_id
      
      t.timestamps
    end

    create_table :followings do |t|
      t.integer :profile_id
      t.integer :follower_id
      t.boolean :blocked

      t.timestamps
    end
    
    create_table :profile_activities do |t|
      t.integer :profile_id
      t.integer :actor_id
      t.string  :name
      t.string  :detail
      t.timestamps
    end
  end

end
