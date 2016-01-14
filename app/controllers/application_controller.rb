class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private

  def set_current_user
    authenticate_or_request_with_http_token do |token|
      begin
        payload = AuthToken.decode(token)
        @cur_user = User.find_by(id: payload["user_id"])
        check_current_user_is_logged_in
      rescue JWT::ExpiredSignature
        render json: { error: "Your token has expired" }
      rescue JWT::DecodeError
        render json: { error: "invalid token" }
      end
    end
  end

  def check_current_user_is_logged_in
    @cur_user && @cur_user.logged_in?
  end
end
