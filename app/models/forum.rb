class Forum < ApplicationRecord

    has_many :topics, dependent: :destroy
    
    validates :name,:description, :presence => true
	validates :name, :uniqueness => true
	validates :name, length: { minimum: 3 }	

	default_scope { includes(:topics)}
end
