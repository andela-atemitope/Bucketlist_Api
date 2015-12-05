class Api::V1::UsersController < ApplicationController
  
  skip_before_action :set_current_user, :authenticate_request, only: [:create]
  # def show
  #   user = User.find(params[:id])

  #   render(json: Api::V1::UserSerializer.new(user).to_json)
  # end


  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private 
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
