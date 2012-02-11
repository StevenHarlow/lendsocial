class CreateBusinessFollowings < ActiveRecord::Migration
  def change
    create_table :business_followings do |t|
      t.references :follower
      t.references :followed

      t.timestamps
    end
    add_index :business_followings, :follower_id
    add_index :business_followings, :followed_id
  end
end
