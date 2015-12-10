class Api::V1::AuthController < ApplicationController
   skip_before_action :set_current_user, only: [:authenticate] # this will be implemented later



  def authenticate
    user = User.find_by(email: params[:email]) # you'll need to implement this
    if user && user.authenticate(params[:password])
      user.log_in
      render json: { auth_token: user.generate_auth_token }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def logout 
    if @current_user
      @current_user.log_out
    else
      render json: { error: 'you are not logged in' }, status: :unauthorized
    end
  end
end
