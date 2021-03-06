class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update, :destroy, :follow, :unfollow]
  before_filter :find_user, except: [:index, :new, :create]
  before_filter :current_user_is_allowed_to, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @post = @user.postings.build(author_id: current_user.id)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html do
          redirect_to @user, notice: 'User was successfully created.'
        end
      else
        format.html do
          render action: "new"
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update_without_password(params[:user])
        format.html do
          redirect_to @user, notice: 'User was successfully updated.'
        end
      else
        format.html do
          render action: "edit"
        end
      end
    end
  end

  def comments
    @messages = Message.for_user(@user).with_comments.page(params[:page] || 1)
    respond_to_xhr 'messages/list'
  end

  def follow
    current_user.follow(@user)
    render partial: 'widgets/user_follow'
  end

  def unfollow
    current_user.unfollow(@user)
    render partial: 'widgets/user_follow'
  end

  def followers
    @followers = @user.latest_followers.page(params[:page] || 1)
    redirect_to followers_user_path(page: 1) if @followers.empty?
  end

  def followings
    @followings = @user.latest_followings.page(params[:page] || 1)
    redirect_to followings_user_path(page: 1) if @followings.empty?
  end

  def business_followings
    @business_followings = @user.latest_business_followings.page(params[:page] || 1)
    redirect_to business_followings_user_path(page: 1) if @business_followings.empty?
  end

  def latest_followers
    if request.xhr?
      render partial: 'widgets/user_followers', locals: {followers: @user.latest_followers(3)}
    else
      redirect_to followers_user_path
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
  
  def current_user_is_allowed_to
    path = params[:id].blank? ? root_path : user_path(params[:id])
    redirect_to path unless user_signed_in? && current_user == @user
  end

  def respond_to_xhr template
    if request.xhr?
      render template: template, layout: false
    else
      redirect_to url_for(@user)
    end
  end

end
