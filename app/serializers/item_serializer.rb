
class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :bucketlist_id, :created_at, :updated_at, :bucketlist_name

  def bucketlist_name
    id = object.bucketlist_id
    Bucketlist.find_by_id(id)
  end

end

