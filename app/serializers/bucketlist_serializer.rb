
class BucketlistSerializer < ActiveModel::Serializer
  attributes  :name, :id, :created_at, :updated_at, :created_by

  has_many :items

  def created_by
    id = object.user_id 
    User.find_by_id(id).username
  end
end

