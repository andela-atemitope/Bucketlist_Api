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

  def self.check_user_list(user_id, list_id)
    bucket_list = Bucketlist.find(list_id)
    if bucket_list.nil? || bucket_list.user_id == user_id
      bucket_list
    else
      {unauthorized: "You do not have permission to view this list"}
    end
  end


  def self.set_limit(limit)
    case 
      when limit.nil? || limit.to_i < 0
        20
      when limit.to_i > 100
        100
      else
        limit.to_i
    end
  end

  def self.paginate(search_result, limit = nil, pages = nil)
    total_items = limit.to_i * pages.to_i
    offset = total_items - limit.to_i 
    display = search_result.limit(limit).offset(offset)
    result_message(display)
  end


  def self.result_message(result) 
    # require 'pry'; binding.pry
    if result.empty? || result.blank?
      return { error: "no results found for query" }
    else      
      return result
    end
  end 

end


