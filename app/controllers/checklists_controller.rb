class ChecklistsController < ApplicationController
  before_action :set_checklist, only: [:show, :edit, :update, :destroy]
#  before_action :require_admin_logged_in, only: [:show]

  def index
    @checklists = Checklist.order(created_at: :desc).page(params[:page]).per(25)
  end
  
  def show
  end

  def new
    @checklist = Checklist.new
  end

  def create
    @checklist = current_admin.checklists.build(checklist_params)
    
    if @checklist.save
      flash[:success] = 'トレーニング項目が正常に登録されました'
      redirect_to root_url
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
    @checklist.destroy
    
    flash[:success] = 'トレーニング項目は正常に削除されました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def set_checklist
    @checklist = Checklist.find(params[:id])
  end
  
  # Strong Parameter
  def checklist_params
    params.require(:checklist).permit(:id, :grade, :chapter, :section, :content, :admin_id)
  end
end
