class ProfileActivity < ActiveRecord::Base
    belongs_to :profile
    belongs_to :actor, :class_name => 'User'
    
    def self.follow_activity( profile, actor )
        self.new( { :profile_id => profile.id, :actor_id => actor.id, :name => 'follow'} )
    end
end
