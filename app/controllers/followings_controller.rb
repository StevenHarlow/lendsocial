class FollowingsController < ApplicationController
    
    # POST /followings
    # POST /followings.json
    def create
      @following = Followings.new
      @following.profile_id = params[:profile][:id]
      @following.follower_id = current_user.id
      respond_to do |format|
        if @following.save
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
      
       @profile = Profile.find( params[:profile][:id] )

       respond_to do |format|
         format.html { render :partial => "not_following", :locals => { :profile => @profile } } 
         format.json { head :ok }
       end
     end
end
