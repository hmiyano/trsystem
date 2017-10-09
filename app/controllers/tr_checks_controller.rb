class TrChecksController < ApplicationController
  def create
    checklist = Checklist.find(params[:checklist_id])
    current_trainer.master(checklist)
    flash[:success] = '項目をMASTERしました'
    redirect_to root_url
  end

  def destroy
    checklist = Checklist.find(params[:checklist_id])
    current_trainer.unmaster(checklist)
    flash[:success] = 'MASTERを解除しました'
    redirect_to root_url
  end
end
