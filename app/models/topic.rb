class Topic < ApplicationRecord


    belongs_to :forum

    has_many :comments,dependent: :destroy	

    validates :name,:description, :presence => true
	validates :name, length: { minimum: 5 }
	validates :description, length: { minimum: 100 }
end
