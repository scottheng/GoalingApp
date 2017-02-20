class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      login(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = ["Invalid credentials"]
      render :new
    end
  end

  def destroy
    session[:session_token] = nil
    current_user.try(:reset_session_token!)
    redirect_to new_session_url
  end
end
