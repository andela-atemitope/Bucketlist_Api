class Bucketlist < ActiveRecord::Base
  has_many :items
  belongs_to :user

  before_save { self.name = name.strip.capitalize }

  VALID_BUCKETLIST_NAME_REGEX = /\A[a-z0-9\-_]+\z/i
  validates :name,  presence: true, 
                    length: { in: 4..140 },
                    format: {with: VALID_BUCKETLIST_NAME_REGEX }

  # VALID_ID_REGEX = /^[0-9]+$/i
  validates :user_id, presence: true
                      # format: {with: VALID_ID_REGEX}

  def self.search_result(current_user, query)
    Bucketlist.where("name LIKE '#{query}' AND user_id = '#{current_user}'")
  end
end
