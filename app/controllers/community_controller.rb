class CommunityController < ApplicationController
  def index
    @businesses = Business.all
    @users = User.all
  end
end