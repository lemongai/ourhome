class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :room, presence: true, length: { maximum: 4 },
                   format: { with: /\A[0-9]+\z/ },
                   uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
end
