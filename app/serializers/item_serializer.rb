
class ItemSerializer < ActiveModel::Serializer
  attributes :name, :id, :done, :created_at, :updated_at
end
