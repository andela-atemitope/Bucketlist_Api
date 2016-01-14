module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :set_current_user, only: [:create]

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
        params.permit(:username, :email, :password)
      end
    end
  end
end
