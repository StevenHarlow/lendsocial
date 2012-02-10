class CreateUserFollowings < ActiveRecord::Migration
  def change
    create_table :user_followings do |t|
      t.references :follower
      t.references :followed

      t.timestamps
    end
    add_index :user_followings, :follower_id
    add_index :user_followings, :followed_id
  end
end
