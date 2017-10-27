class Pg1akChecklistsController < ApplicationController
  before_action :set_checklist, only: [:show, :edit, :update, :destroy]

  def index

    if params[:chapname] == 'ALL'
      @pg1ak_checklists = Pg1akChecklist.order(created_at: :asc).page(params[:page]).per(25)
    elsif params[:chapname]
      @pg1ak_checklists = Pg1akChecklist.where(chapter: params[:chapname]).order(created_at: :asc).page(params[:page]).per(25)
    else
      @pg1ak_checklists = Pg1akChecklist.order(created_at: :desc).page(params[:page]).per(25)
    end
  end
  
  def show

  end

  def new
    @pg1ak_checklist = Pg1akChecklist.new
    pg1ak_checklist = Pg1akChecklist.new
  end

  def create
    @pg1ak_checklist = current_admin.pg1ak_checklists.build(checklist_params)
    
    if @pg1ak_checklist.save
      flash[:success] = 'トレーニング項目が正常に登録されました'
      redirect_to new_pg1ak_checklist_path
    else
      flash.now[:danger] = 'トレーニング項目が登録されませんでした'
      render :new
    end
  end

  def edit
  end

  def update

    if @checklist.update(checklist_params)
      flash[:success] = 'トレーニング項目は正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'トレーニング項目は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @pg1ak_checklist.destroy
    
    flash[:success] = 'トレーニング項目は正常に削除されました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def set_checklist
    @pg1ak_checklist = Pg1akChecklist.find(params[:id])
  end
  
  # Strong Parameter
  def checklist_params
    params.require(:pg1ak_checklist).permit(:id, :chapter, :section, :content, :admin_id, :enable)
  end
end
