require "rails_helper"

RSpec.describe Item, type: :model do
  subject(:item) { Item.new(name: name, bucketlist_id: id) }
  let(:name) { "Visit_Zanzibar" }
  let(:id) { "1" }

  it { expect(item).to be_valid }
  it { expect(item.done).to eql(false) }

  describe "#name" do
    context "When name is not present" do
      let(:name) { "" }
      it { expect(item).to be_invalid }
    end

    context "When the length of the name is less than 4" do
      let(:name) { "buc" }
      it { expect(item).to be_invalid }
    end

    context "When the length of the name is greater than 140" do
      let(:name) { "test"*200 }
      it { expect(item).to be_invalid }
    end

    context "When the name contains invalid characters" do
      let(:name) { "New Item-=`78`9`++" }
      it { expect(item).to be_invalid }
    end

    context "When the name is not unique" do
      it "The item should be invalid" do
        item.save
        expect(item.name).to eql("Visit_Zanzibar")
        test_item = Item.new(name: name, bucketlist_id: id)
        expect(test_item).to be_invalid
      end
    end
  end

  describe "#bucketlist_id" do
    context "When the bucketlist_id is not present" do
      let(:id) { "" }
      it { expect(item).to be_invalid }
    end
  end

  describe "Item associations" do
    it "The item should belong to a bucketlist" do
      item.save
      expect(item.id).to eql(1)
      bucketlist = Bucketlist.create(name: "My_Bucketlist", user_id: "1")
      bucketlist.save
      item = Item.find(1).bucketlist_id
      expect(item).to eql(1)
    end
  end 
end