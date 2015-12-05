class User < ActiveRecord::Base
  has_secure_password
  has_many :bucketlists, dependent: :destroy
  has_many :items, through: :lists
 

  VALID_USERNAME_REGEX = /\A[a-z0-9\-_]+\z/i
  validates :username,  presence: true, 
                        length: { in: 4..100 },
                        format: {with: VALID_USERNAME_REGEX }, 
                        uniqueness: {case_sensitive: false }

  VALID_EMAIL_REGEX = /\A[\w]+\.?[\w]+@[a-z\d\.]+[\w]+\.[a-z]+\z/i
  validates :email, presence: true, 
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }


  validates :password,  presence: true, 
                        length: {in: 4..20}

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
