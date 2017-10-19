class Comment < ApplicationRecord
  belongs_to :trainee
#  belongs_to :trainer
  
  validates :trainee_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  
end
