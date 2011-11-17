class FollowingsController < ApplicationController
    
    
    def index
       @following =  Followings.where( :follower_id => current_user.id )
    
       respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @following }
        end
        
    end
    
    # POST /followings
    # POST /followings.json
    def create
      @following = Followings.new
      @following.profile_id = params[:profile][:id]
      @following.follower_id = current_user.id
      @activity = ProfileActivity.new( { :profile_id => @following.profile_id, :actor_id => current_user.id, :name => 'follow'} )
      
      respond_to do |format|
        if @following.save
          @activity.save
          format.html { render :partial => "following", :locals => { :profile => @following.profile } }
          format.json { render json: @following, status: :created, location: @following }
        else
          format.html { render :partial => "failure" }
          format.json { render json: @following.errors, status: :unprocessable_entity }
        end
      end
    end
    
    def destroy
       @following = Followings.where( :follower_id => current_user.id, :profile_id => params[:profile][:id] ).first
       @following.destroy
       @activity = ProfileActivity.new( { :profile_id => @following.profile_id, :actor_id => current_user.id, :name => 'unfollow'} )
       @activity.save
      
       @profile = Profile.find( params[:profile][:id] )

       respond_to do |format|
         format.html { render :partial => "not_following", :locals => { :profile => @profile } } 
         format.json { head :ok }
       end
     end
end
