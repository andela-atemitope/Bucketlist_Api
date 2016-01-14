class Item < ActiveRecord::Base
  belongs_to :bucketlist

  VALID_ITEM_NAME_REGEX = /\A[a-z0-9\-_]+\z/i
  validates :name,  presence: true,
                    length: { in: 4..140 },
                    format: { with: VALID_ITEM_NAME_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :bucketlist_id, presence: true
end
