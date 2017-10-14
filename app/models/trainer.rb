class Trainer < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :nickname, presence: true, length: { maximum: 50 }
  validates :branch, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }  
  has_secure_password
  
  has_many :tr_checks
  has_many :checklists, through: :tr_checks
  
  has_many :tr_checks
  has_many :masterings, through: :tr_checks, source: :checklist
  
  def master(checklist, trainee)
    unless tr_checks.find_by(checklist_id: checklist.id, trainee_id: trainee.id)
      self.tr_checks.find_or_create_by(checklist_id: checklist.id, trainee_id: trainee.id)
    end
  end
  
  #  def unmaster(checklist, trainee)
  #    tr_check = tr_checks.find_by(checklist_id: checklist.id, trainee_id: trainee.id)
  #    tr_check.destroy if tr_check
  #  end
  
  def mastering?(checklist)
    self.masterings.include?(checklist)
  end

end
