class ChecklistsController < ApplicationController
  before_action :set_checklist, only: [:show, :edit, :update, :destroy]
#  before_action :require_admin_logged_in, only: [:show]

  def index

    if params[:selfcheck] == 'ALL'
      @checklists = Checklist.order(created_at: :asc).page(params[:page]).per(25)
    elsif params[:selfcheck]
      @checklists = Checklist.joins(:te_checks).where("te_checks.type = '#{params[:selfcheck]}' and te_checks.trainee_id = #{@trainee.id}")
      @checklists = @checklists.order(created_at: :asc).page(params[:page]).per(25)
    elsif params[:wgname] == "ALL"
      @checklists = Checklist.order(created_at: :asc).page(params[:page]).per(25)
    elsif params[:wgname] == "pg1ac"
      @checklists = Checklist.where(pg1ac: true).order(created_at: :asc).page(params[:page]).per(25)
    elsif params[:wgname] == "pg1ak"
      @checklists = Checklist.where(pg1ak: true).order(created_at: :asc).page(params[:page]).per(25)
    elsif params[:chapname] == "ALL"
      @checklists = Checklist.order(created_at: :asc).page(params[:page]).per(25)
    elsif params[:chapname]
      @checklists = Checklist.where(chapter: params[:chapname]).order(created_at: :asc).page(params[:page]).per(25)
    elsif params[:master]
      if params[:master] == 'yes'
        @checklists = Checklist.joins(:tr_checks).where("tr_checks.trainee_id = #{@trainee.id}")
        @checklists = @checklists.order(created_at: :asc).page(params[:page]).per(25)
      elsif params[:master] == 'wait'
        @checklists = Checklist
                        .joins("left join te_checks on te_checks.checklist_id = checklists.id")
                        .joins("left join tr_checks on tr_checks.checklist_id = checklists.id and tr_checks.trainee_id = #{@trainee.id}")
                        .where("te_checks.type = 'Third'").where("te_checks.trainee_id = #{@trainee.id}")
                        .where("tr_checks.checklist_id is null")
        @checklists = @checklists.order(created_at: :asc).page(params[:page]).per(25)
      end
    elsif params[:chapname] == "ALL"
      @checklists = Checklist.order(created_at: :asc).page(params[:page]).per(25)
    else
      @checklists = Checklist.order(created_at: :desc).page(params[:page]).per(25)
    end

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
    params.require(:checklist).permit(:id, :chapter, :section, :content, :admin_id, :pg1ac, :pg1ak)
  end
end
