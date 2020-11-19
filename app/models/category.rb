class Category < ApplicationRecord
  has_many :topic_categories
  has_many :topics, through: :topic_categories
end
