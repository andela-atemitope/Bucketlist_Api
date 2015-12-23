class Bucketlist < ActiveRecord::Base
  has_many :items
  belongs_to :user

  before_save { self.name = name.strip.capitalize }

  VALID_BUCKETLIST_NAME_REGEX = /\A[a-z0-9\-_]+\z/i
  validates :name,  presence: true, 
                    length: { in: 4..140 },
                    format: { with: VALID_BUCKETLIST_NAME_REGEX }

  # VALID_ID_REGEX = /^[0-9]+$/i
  validates :user_id, presence: true
                      # format: {with: VALID_ID_REGEX}

  def self.search_result(current_user, query)
    Bucketlist.where("name LIKE '#{query}' AND user_id = '#{current_user}'")
  end

  def self.check_user_list(user_id, list_id)
    bucket_list = Bucketlist.find(list_id)
    if bucket_list.nil? || bucket_list.user_id == user_id
      bucket_list
    else
      { unauthorized: "You do not have permission to view this list"}
    end
  end
end
