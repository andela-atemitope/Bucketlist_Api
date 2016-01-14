module Api
  module V1
    class AuthController < ApplicationController
      before_action :set_current_user, only: [:logout]

      def authenticate
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          user.log_in
          render json: { auth_token: user.generate_auth_token(user) }
        else
          render json: { error: "Invalid username or password" },
                 status: :unauthorized
        end
      end

      def logout
        if @cur_user
          @cur_user.log_out
          render json: { message: "you are successfully logged out" }
        else
          render json: { error: "you are not logged in" },
                 status: :unauthorized
        end
      end
    end
  end
end
