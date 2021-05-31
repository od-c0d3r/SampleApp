class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      reset_session
      remember user
      log_in user
      flash[:success] = 'Welcome Back!'
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      # display error messages
      render 'new'
    end
  end

  def destroy
    log_out
    clear_cookies
    redirect_to root_url
  end
  
end
