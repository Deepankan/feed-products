class Product < ApplicationRecord
  self.per_page = 10

  belongs_to :provider, optional: true
  belongs_to :category

  CATEGORIES = ['categories', 'category', 'tags', 'tag']
  NAME = ['name', 'title']
end
