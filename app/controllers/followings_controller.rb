class FollowingsController < ApplicationController
    
    # POST /followings
    # POST /followings.json
    def create
      @following = Followings.new
      @following.profile_id = params[:profile][:id]
      @following.follower_id = current_user.id
      respond_to do |format|
        if @following.save
          format.html { render :partial => "following" }
          format.json { render json: @following, status: :created, location: @following }
        else
          format.html { render :partial => "failure" }
          format.json { render json: @following.errors, status: :unprocessable_entity }
        end
      end
    end
    
end
