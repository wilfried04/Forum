class Comment < ApplicationRecord
    belongs_to :topic
    validate :description, :presence => true
end
