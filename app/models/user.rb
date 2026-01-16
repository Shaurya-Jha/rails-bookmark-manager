class User < ApplicationRecord
  # method will ensure the password is hashed using bcrypt and stored in the 'password_digest' field
  has_secure_password

  # validations
  validates :email, presence: true, uniqueness: true

  has_many :links, dependent: :destroy
end
