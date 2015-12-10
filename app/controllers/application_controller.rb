class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  private

  def set_current_user
    authenticate_or_request_with_http_token do |token, option|  
      payload = AuthToken.decode(token)
      @current_user = User.find_by(id: payload["user_id"])
      check_current_user_is_logged_in
    end
  end

  def check_current_user_is_logged_in
    @current_user && @current_user.logged_in?
  end
end
