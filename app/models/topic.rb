class Topic < ApplicationRecord
    validates :content, presence:true
    validates :image, presence:true
  
end