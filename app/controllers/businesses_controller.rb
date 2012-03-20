class BusinessesController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :followers, :latest_followers, :connections, :latest_connections, :comments]
  before_filter :find_business, except: [:new, :create]
  before_filter :find_object, only: [:connect, :accept_response, :ignore_response, :cancel_request]
  before_filter :current_user_is_allowed_to, only: [:edit, :update, :destroy]

  def show
    @post = @business.postings.build(author_id: current_user.id)
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(params[:business])
    @business.users << current_user

    respond_to do |format|
      if @business.save
      format.html { redirect_to @business, notice: 'Business was successfully created.' }
      format.json { render json: @business, status: :created, location: @business }
      else
      format.html { render action: "new" }
      format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  def follow
    return false if current_user.is_following?(@business)
    current_user.follow(@business)
    render partial: 'widgets/business_follow'
  end

  def unfollow
    return false unless current_user.is_following?(@business)
    current_user.unfollow(@business)
    render partial: 'widgets/business_follow'
  end

  def followers
    @followers = @business.latest_followers.page(params[:page] || 1)
    redirect_to followers_business_path(page: 1) if @followers.empty?
  end

  def latest_followers
    if request.xhr?
      render partial: 'widgets/business_followers', locals: {followers: @business.latest_followers(3)}
    else
      redirect_to followers_business_path
    end
  end

  def connect
    return false unless @object.present?
    @business.request(@object, params[:message])
    connect_button_to_xhr
  end

  def cancel_request
    return false unless @object.present?
    @business.response(@object, :cancelled)
    connect_button_to_xhr
  end

  def connections
    @connections = @business.latest_connections.page(params[:page] || 1)
    redirect_to connections_business_path(page: 1) if @connections.empty?
  end

  def latest_connections
    if request.xhr?
      render partial: 'widgets/business_connections', locals: {connections: @business.latest_connections(3)}
    else
      redirect_to connections_business_path
    end
  end

  def accept_response
    return false unless @object.present?
    @business.response(@object, :accepted)
    notifications_to_xhr
  end

  def ignore_response
    return false unless @object.present?
    @business.response(@object, :ignored)
    notifications_to_xhr
  end

  def comments
    @messages = Message.for_business(@business).where(:related_message_id => nil).with_comments.page(params[:page] || 1)
    respond_to_xhr
  end

  def edit

  end


  def update
    respond_to do |format|
      if @business.update_attributes(params[:business])
        format.html do
          redirect_to @business, notice: 'Business was successfully updated.'
        end
      else
        format.html do
          render action: "edit"
        end
      end
    end
  end

  private

  def find_business
    @business = Business.find(params[:id])
  end

  def find_object
    @object = Business.find(params[:business])
  end

  def respond_to_xhr
    if request.xhr?
      respond_to do |format|
        format.html {render template: 'messages/list', layout: false}
      end
    else
      redirect_to url_for(@business)
    end
  end

  def notifications_to_xhr
    if request.xhr?
      @notifications = current_user.business_notifications.page(1)
      render template: 'notifications/list', layout: false
    else
      redirect_to dashboard_index_path
    end
  end
  
  def current_user_is_allowed_to
    path = params[:id].blank? ? root_path : business_path(params[:id])
    redirect_to path unless user_signed_in? && current_user == @business.owner
  end

  def connect_button_to_xhr
    if request.xhr?
      render partial: 'widgets/connect', locals: {business: @object}
    else
      redirect_to connects_business_path
    end
  end

end
