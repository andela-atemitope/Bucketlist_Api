class User < ActiveRecord::Base
  has_many :bucketlists, dependent: :destroy
  has_many :items, through: :lists
 
  validates :full_name,  presence: true, length: { maximum: 150 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end
