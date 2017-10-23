class ToppagesController < ApplicationController

  def index
    @checklists = Checklist.order('updated_at DESC')
    @trainees = Trainee.all
    @trainee = current_trainee
  end
  
  def show
#    @trainee = Trainee.find(params[:id])
  end
end
