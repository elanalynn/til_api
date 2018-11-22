class Item < ApplicationRecord
  has_many :tags, dependent: :destroy
  validates_presence_of :content, :date
end
