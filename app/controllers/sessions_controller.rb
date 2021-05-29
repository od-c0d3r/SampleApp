class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      reset_session
      log_in user
      flash[:success] = 'Welcome Back!'
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      # display error messages
      render 'new'
    end
  end
end
