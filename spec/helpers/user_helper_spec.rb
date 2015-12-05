require 'rails_helper'

  def create_user_for_test
    User.create(username: "Oscar", 
                email: "oscillo@gmail.com", 
                password: "oscarpalito")
  end
