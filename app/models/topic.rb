class Topic < ApplicationRecord
  validates_presence_of :name, :title, :category_ids, presence: true
  belongs_to :user
  has_many :topic_categories
  has_many :categories, through: :topic_categories
  has_many :comments, dependent: :destroy

  def self.search(keyword)

  end
end
