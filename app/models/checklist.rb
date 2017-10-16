class Checklist < ApplicationRecord
  
  belongs_to :admin
  
  #バリデーション
  validates :admin_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  validates :grade, presence: true, length: { maximum: 255 }
  validates :section, presence: true, length: { maximum: 255 }
  validates :chapter, presence: true, length: { maximum: 255 }
  
  # te_check テーブルを通じて trainees と多対多の関係性
  has_many :te_checks
  has_many :trainees, through: :te_checks
  
  # tr_check テーブルを通じて trainers と多対多の関係性
  has_many :tr_checks
  has_many :trainers, through: :tr_checks
  
  has_many :firsts
  has_many :first_trainees, through: :firsts, class_name: 'Trainee', source: :trainee
  
  has_many :seconds
  has_many :second_trainees, through: :seconds, class_name: 'Trainee', source: :trainee
  
  has_many :thirds
  has_many :third_trainees, through: :thirds, class_name: 'Trainee', source: :trainee
  
  scope :selfcheck, -> (trainee_id, type) {
    joins(:te_checks).where(trainee_id: trainee_id).where(type: type)
  }
end
