class Provider < ApplicationRecord
  self.per_page = 10

  belongs_to :user

  has_many :products
end
