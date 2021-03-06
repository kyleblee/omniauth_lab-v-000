class SessionsController < ApplicationController

  def create
    if @auth = request.env['omniauth.auth']
      @user = User.find_or_create_by_omniauth(@auth)
      session[:user_id] = @user.id
    else
      @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
      else
        render :new
      end
    end
  end
end
