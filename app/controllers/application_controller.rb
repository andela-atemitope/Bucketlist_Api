class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  # before_action :this_is_current_user
  # rescue_from NotAuthenticatedError do
  #   render json: { error: 'Not Authorized' }, status: :unauthorized
  # end
  # rescue_from AuthenticationTimeoutError do
  #   render json: { error: 'Auth token is expired' }, status: 419 # unofficial timeout status code
  # end

  private

  # Based on the user_id inside the token payload, find the user.
  # def set_current_user
  #   if decoded_auth_token
  #     @current_user ||= User.find(decoded_auth_token[:user_id])
  #   end
  # end

  # # Check to make sure the current user was set and the token is not expired
  # def authenticate_request
  #   if auth_token_expired?
  #     render json: { error: 'Auth token is expired' }, status: 419 # unofficial timeout status code
  #   elsif check_current_user_is_logged_in
  #     render json: { error: 'You are not logged in' }, status: :unauthorized
  #   else 
  #     render json: { error: 'You are not Authorized'}, status: :unauthorized
  #   end
  # end

  # def decoded_auth_token
  #   @decoded_auth_token ||= AuthToken.decode(http_auth_header_content)
  #   require 'pry'; binding.pry
  # end

  # def auth_token_expired?
  #   decoded_auth_token && decoded_auth_token.expired?
  # end



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


 # def http_auth_header_content
 #    return @http_auth_header_content if defined? @http_auth_header_content
 #    @http_auth_header_content = begin
 #      if request.headers['Authorization'].present?
 #        request.headers['Authorization'].split(' ').last
 #      else
 #        nil
 #      end
 #    end
  end
# end