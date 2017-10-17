class TrChecksController < ApplicationController
  def create
    ajax_action unless params[:ajax_handler].blank?

    # Ajaxリクエストではない時の処理
    checklist = Checklist.find(params[:checklist_id])
    trainee = Trainee.find(params[:trainee_id])
    current_trainer.master(checklist, trainee)
    flash[:success] = '項目をMASTERしました'
#    redirect_back(fallback_location: root_path)
  end

  def destroy
    checklist = TrCheck.find_by(checklist_id:params[:checklist_id])
    checklist.destroy
    flash[:success] = 'MASTERを解除しました'
    redirect_back(fallback_location: root_path)
  end
  
  def ajax_action
    if params[:ajax_handler] == 'handle_master'
      # Ajaxの処理
    checklist = Checklist.find(params[:checklist_id])
    trainee = Trainee.find(params[:trainee_id])
    current_trainer.master(checklist, trainee)
    flash[:success] = '項目をMASTERしました'
    render
#    redirect_back(fallback_location: root_path)  
    else
      render json: 'no data'
    end
  end
end
