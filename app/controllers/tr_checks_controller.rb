class TrChecksController < ApplicationController
  def create
    checklist = Checklist.find(params[:checklist_id])
    trainee = Trainee.find(params[:trainee_id])
    current_trainer.master(checklist, trainee)
    flash[:success] = '項目をMASTERしました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    checklist = TrCheck.find_by(params[:checklist_id], params[:trainee_id])
    checklist.destroy
    flash[:success] = 'MASTERを解除しました'
    redirect_back(fallback_location: root_path)
  end
end
