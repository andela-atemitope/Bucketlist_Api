
class BucketlistSerializer < ActiveModel::Serializer
  attributes :id, :name, :items, :created_at, :updated_at, :created_by

  def created_by
    id = object.user_id 
    User.find_by_id(id).username
  end
end

