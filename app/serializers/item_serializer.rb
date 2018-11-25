class ItemSerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :created_at, :updated_at
  has_many :tags
end
