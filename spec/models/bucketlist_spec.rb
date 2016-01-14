require "rails_helper"


RSpec.describe Bucketlist, type: :model do
  subject(:bucketlist) { Bucketlist.new
                          ( name: name,
                            user_id: user_id
                            ) }
  let(:name) { "specialbucketlist" }
  let(:user_id) { 1 }

  it { expect(bucketlist).to be_valid }

  describe "#name" do
    context "When name is not present" do
      let(:name) { "" }
      it { expect(bucketlist).to be_invalid }
    end

    context "When the length of the name is less than 4" do
      let(:name) { "osc" }
      it { expect(bucketlist).to be_invalid }
    end

    context "When the length of the name is greater than 140" do
      let(:name) { "oscar" * 60 }
      it { expect(bucketlist).to be_invalid }
    end

    context "When the name contains invalid characters" do
      let(:name) { "Oscilloj000_+++!" }
      it { expect(bucketlist).to be_invalid }
    end
  end

  describe "#user_id" do
    context "When the user_id is not present" do
      let(:user_id) { "" }
      it { expect(bucketlist).to be_invalid }
    end
  end
end
