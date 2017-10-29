class Trainee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :nickname, presence: true, length: { maximum: 10 }
  validates :branch, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }  
  has_secure_password
  
  has_many :te_checks, :dependent => :nullify
  has_many :checklists, through: :te_checks
  
  has_many :tr_checks, :dependent => :nullify
  has_many :checklists, through: :tr_checks
  
  has_many :firsts
  has_many :first_checklists, through: :firsts, class_name: 'Checklist', source: :checklist
  
  has_many :seconds
  has_many :second_checklists, through: :seconds, class_name: 'Checklist', source: :checklist
  
  has_many :thirds
  has_many :third_checklists, through: :thirds, class_name: 'Checklist', source: :checklist
  
  has_many :comments, :dependent => :nullify

  def first(checklist)
    self.firsts.find_or_create_by(checklist_id: checklist.id)
  end
  
  def unfirst(checklist)
    first = self.firsts.find_by(checklist_id: checklist.id)
    first.destroy if first
  end
  
  def first?(checklist)
    self.first_checklists.include?(checklist)
  end
  
  def second(checklist)
    self.seconds.find_or_create_by(checklist_id: checklist.id)
  end
  
  def unsecond(checklist)
    second = self.seconds.find_by(checklist_id: checklist.id)
    second.destroy if second
  end
  
  def second?(checklist)
    self.second_checklists.include?(checklist)
  end
  
  def third(checklist)
    self.thirds.find_or_create_by(checklist_id: checklist.id)
  end
  
  def unthird(checklist)
    third = self.thirds.find_by(checklist_id: checklist.id)
    third.destroy if third
  end
  
  def third?(checklist)
    self.third_checklists.include?(checklist)
  end

  def chapcount(wg, chapter, trainee)
    lists = Checklist.where("#{wg}": true).where(chapter: chapter)
    tchecks = TeCheck.where(trainee_id: trainee.id)

    result = 0
    lists.each do |list|
      result += tchecks.where(checklist_id: list.id).count
    end
    return result
  end
  
end
