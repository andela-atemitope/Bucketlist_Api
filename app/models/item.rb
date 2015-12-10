class Item < ActiveRecord::Base
	belongs_to :bucketlist

	VALID_ITEM_NAME_REGEX = /\A[a-z0-9\-_]+\z/i
	validates :name,  presence: true, 
										length: { in: 4..140 },
										format: {with: VALID_ITEM_NAME_REGEX }, 
										uniqueness: {case_sensitive: false }

	# VALID_ID_REGEX = /^[0-9]+$/i
	validates :bucketlist_id, presence: true
														# format: {with: VALID_ID_REGEX}
end
