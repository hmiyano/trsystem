class ToppagesController < ApplicationController

  def index
    @checklists = Checklist.order('updated_at DESC')
    @trainees = Trainee.all
    @trainee = current_trainee
    
    # @trainee の対象チェックリストのみを表示する
    allow_grades = $all_grades.select { |permit| @trainee.try(permit) }
    allow_grades_query = allow_grades.map { |a| "#{a.to_s} = true"}.join(" OR ")

    # progress 確認用
    @progresslists = Checklist.where(allow_grades_query) 
    
  end
  
  def show
    @trainee = Trainee.find(params[:id])
  end
end
