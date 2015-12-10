class Bucketlist < ActiveRecord::Base
  has_many :items
  belongs_to :user

  VALID_BUCKETLIST_NAME_REGEX = /\A[a-z0-9\-_]+\z/i
  validates :name,  presence: true, 
                    length: { in: 4..140 },
                    format: {with: VALID_BUCKETLIST_NAME_REGEX }, 
                    uniqueness: {case_sensitive: false }

  # VALID_ID_REGEX = /^[0-9]+$/i
  validates :user_id, presence: true
                      # format: {with: VALID_ID_REGEX}
end
