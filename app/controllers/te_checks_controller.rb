class TeChecksController < ApplicationController
  
  def create
    checklist = Checklist.find(params[:checklist_id])

    if params[:type] == 'First'
      current_trainee.first(checklist)
      flash[:success] = '1回目のトレーニングが完了しました'
      
    elsif params[:type] == 'Second'
      current_trainee.second(checklist)
      flash[:success] = '2回目のトレーニングが完了しました'

    elsif params[:type] == 'Third'
      current_trainee.third(checklist)
      flash[:success] = '3回目のトレーニングが完了しました'
    end
    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    checklist = Checklist.find(params[:checklist_id])
    if params[:type] == 'First'
      current_trainee.unfirst(checklist)
      flash[:danger] = '1回目のトレーニング完了を取り消しました'
    elsif params[:type] == 'Second'
      current_trainee.unsecond(checklist)
      flash[:danger] = '2回目のトレーニング完了を取り消しました'
    elsif params[:type] == 'Third'
      current_trainee.unthird(checklist)
      flash[:danger] = '3回目のトレーニング完了を取り消しました'
    end
    
    redirect_back(fallback_location: root_path)
  end
end
