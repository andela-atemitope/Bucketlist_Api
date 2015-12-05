class User < ActiveRecord::Base
  has_secure_password
  has_many :bucketlists, dependent: :destroy
  has_many :items, through: :lists
 
  validates :username,  presence: true, length: { maximum: 150 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }


  def generate_auth_token
    payload = { user_id: self.id }
    AuthToken.encode(payload)
  end


  def log_in
    update(logged_in: true)
  end

  def log_out
    update(logged_in: false)
  end
end
