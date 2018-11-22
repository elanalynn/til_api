class User < ApplicationRecord
  has_secure_password
  has_many :items
  validates_presence_of :first_name, :last_name, :email, :password_digest
end
