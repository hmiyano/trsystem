class ChecklistsController < ApplicationController
  before_action :set_checklist, only: [:show, :edit, :update, :destroy]
#  before_action :require_admin_logged_in, only: [:show]

  def index

    sortedlist = Checklist.order(created_at: :asc).page(params[:page]).per(25)

    if params[:wgname] == ""
      params[:wgname] = session[:wg]
    end
    
    if params[:wgname] == "全て"
      session[:wg] = params[:wgname]
    elsif params[:wgname]
      session[:wg] = params[:wgname]
      sortedlist = sortedlist.where("#{session[:wg]}": true).order(created_at: :asc).page(params[:page]).per(25)
    elsif session[:wg].nil? || session[:wg] == "全て" || session[:wg] == "ALL"
    else
      sortedlist = sortedlist.where("#{session[:wg]}": true).order(created_at: :asc).page(params[:page]).per(25)
    end
    
    if  params[:chapname] == ""
      params[:chapname] = session[:chap]
    end
    
    if params[:chapname] == "全て"
      session[:chap] = params[:chapname]
    elsif params[:chapname]      
      session[:chap] = params[:chapname]
      sortedlist = sortedlist.where(chapter: session[:chap]).order(created_at: :asc).page(params[:page]).per(25)
    elsif session[:chap].nil? || session[:chap] == "全て" || session[:chap] == "ALL"

    else
      sortedlist = sortedlist.where(chapter: session[:chap]).order(created_at: :asc).page(params[:page]).per(25)
    end
    
    @checklists = sortedlist
  end
  
  def show
  end

  def new
    @checklist = Checklist.new
    checklist = Checklist.new
  end

  def create
    @checklist = current_admin.checklists.build(checklist_params)
    
    if @checklist.save
      flash[:success] = 'トレーニング項目が正常に登録されました'
      redirect_to new_checklist_path
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
      redirect_to checklists_url
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
    params.require(:checklist).permit(:id, :chapter, :section, :content, :admin_id, :pg1ac, :pg1ak, :pg1bc, :pg1bk, :pg2ac, :pg2ak, :pg2bc, :pg2bk, :pg2cc, :pg2ck, :pg3a, :pg3b, :pg3c, :g1a, :g1b, :g1c, :g1d, :g2a, :g2b, :g2c, :g2d)
  end
end
