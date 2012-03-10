class UserSessionsController < ApplicationController
  def index
    return redirect_to dashboard_index_path if current_user
    @user_session = UserSession.new
    @user = User.new
  end

  def new
    return redirect_to dashboard_index_path if current_user
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])

    respond_to do |format|
      format.any do
        if @user_session.save
          redirect_to dashboard_index_path, notice: 'Login Successfull'
        else
          redirect_to root_path
        end
      end
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy

    respond_to do |format|
      format.any do
        redirect_to root_path
      end
    end
  end
end