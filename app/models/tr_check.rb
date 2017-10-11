class TrCheck < ApplicationRecord
  belongs_to :trainer
  belongs_to :checklist
  
  has_many :trainees
  
end
