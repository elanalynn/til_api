class Tag < ApplicationRecord
  belongs_to :item
  validates_presence_of :label
end
