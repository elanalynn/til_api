class Item < ApplicationRecord
  belongs_to :user
  has_many :tags, dependent: :destroy
  validates_presence_of :content, :date
end
