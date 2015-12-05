require "rails_helper"


RSpec.describe User, type: :model do
  subject(:user) { User.new(username: username,
                            email: email,
                            password: password) }
  let(:username) { "osmondoscar" }
  let(:email) { "osmond@gmail.com" }
  let(:password) { "osmondoranagwa" }

  it { expect(user).to be_valid }

  describe "#username" do
    context "When username is not present" do
      let(:username) { "" }
      it { expect(user).to be_invalid }
    end

    context "When the length of the username is less than 4" do
      let(:username) { "osc" }
      it { expect(user).to be_invalid }
    end

    context "When the length of the username is greater than 100" do
      let(:username) { "oscar"*60 }
      it { expect(user).to be_invalid }
    end

    context "When the name contains invalid characters" do
      let(:username) { "Oscilloj000_+++!" }
      it { expect(user).to be_invalid }
    end

    context "the email contains invalid characters" do
      let(:email) { "osmondoscillo.wuewewe!i98973/l09189" }
      it { expect(user).to be_invalid }
    end
  
    context "When the username is not unique" do
      it "The user should be invalid" do
        user.save
        expect(User.first.username).to eql("osmondoscar")
        new_user = User.new(username: username, password: password)
        expect(new_user).to be_invalid
      end
    end
  end

  describe "#password" do
    context "When the password is not present" do
      let(:password) { "" }
      it { expect(user).to be_invalid }
    end

    context "When the length of the password is less than 8 characters" do
      let(:password) { "s"*3 }
      it { expect(user).to be_invalid }
    end

    context "When the length of the password is greater than 255 characters" do
      let(:password) { "pass"*25 }
      it { expect(user).to be_invalid }
    end
  end


  describe "#email" do
    context "When the email is not present" do
      let(:email) { "" }
      it { expect(user).to be_invalid }
    end

    context "When the length of the email is greater than 255 characters" do
      let(:email) { "ss@gmail"*553 }
      it { expect(user).to be_invalid }
    end

    context "When the password format is not valid" do
      let(:email) { "oscar-oran+gwa@gmail.com@andela.net" }
      it { expect(user).to be_invalid }
    end
  end


  describe "#log_in" do
    it "Updates the user's logged in attribute as true" do
      user = create_user_for_test
      user.save
      expect(user.logged_in).to be false
      user.log_in
      expect(user.logged_in).to be true
    end
  end

  describe "#log_out" do
    it "Updates the user's logged in attribute as false" do
      user = create_user_for_test
      user.log_in
      expect(user.logged_in).to be true
      user.log_out
      expect(user.logged_in).to be false
    end
  end
end