class User < ApplicationRecord
  validates(:name, presence: true, length: { maximum: 50 })
  validates(:email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i })
end
