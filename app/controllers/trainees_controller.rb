class TraineesController < ApplicationController
#  before_action :require_te_logged_in, only: [:show]

  def index
    
    @checklists = Checklist.order('updated_at DESC')

    if admin_logged_in?
      @checklists = Checklist.order('updated_at DESC')
      if params[:branchname] == '全店'
        @trainees = Trainee.order(created_at: :asc).page(params[:page]).per(25)
      elsif params[:branchname]
        @trainees = Trainee.where(branch: params[:branchname]).order(created_at: :asc).page(params[:page]).per(25)
      else
        @trainees = Trainee.order(created_at: :asc).page(params[:page]).per(25)
      end      
    else
      if params[:branchname] == '全店'
        @trainees = te_enable.order(created_at: :asc).page(params[:page]).per(25)
      elsif params[:branchname]
         @trainees = te_enable.where(branch: params[:branchname]).order(created_at: :asc).page(params[:page]).per(25)
      else
        @trainees = te_enable.order(created_at: :asc).page(params[:page]).per(25)
      end
    end
  end
  
  def show
    
    @trainee = Trainee.find(params[:id])

    if te_logged_in?
      @trainee = current_trainee
      @comment = @trainee.comments.build
      @comments = @trainee.comments.order('created_at DESC').page(params[:page]).per(3)
    elsif tr_logged_in?
      @trainer = current_trainer
      @comment = @trainee.comments.build
      @comments = @trainee.comments.order('created_at DESC').page(params[:page]).per(3)
    else
      @comments = @trainee.comments.order('created_at DESC').page(params[:page]).per(3)
    end
    
    
    if params[:selfcheck] == 'ALL'
      @checklists = Checklist.order(created_at: :asc).page(params[:page]).per(25)
    elsif params[:selfcheck]
      @checklists = Checklist.joins(:te_checks).where("te_checks.type = '#{params[:selfcheck]}' and te_checks.trainee_id = #{@trainee.id}")
      @checklists = @checklists.order(created_at: :asc).page(params[:page]).per(25)
    elsif params[:chapname] == "ALL"
      @checklists = Checklist.order(created_at: :asc).page(params[:page]).per(25)
    elsif params[:chapname]
      @checklists = Checklist.where(chapter: params[:chapname]).order(created_at: :asc).page(params[:page]).per(25)
    elsif params[:master]
      if params[:master] == 'yes'
        @checklists = Checklist.joins(:tr_checks).where("tr_checks.trainee_id = #{@trainee.id}")
        @checklists = @checklists.order(created_at: :asc).page(params[:page]).per(25)
      else
        checklist_table = Checklist.arel_table
        trcheck_table = TrCheck.arel_table
        condition = trcheck_table[:trainee_id].eq(checklist_table[:id])
        @checklists = Checklist.where(TrCheck.where(condition).exists.not).all.order(created_at: :asc).page(params[:page]).per(25)
      end
    elsif params[:chapname] == "ALL"
      @checklists = Checklist.order(created_at: :asc).page(params[:page]).per(25)
    else
      @checklists = Checklist.order(created_at: :desc).page(params[:page]).per(25)
    end

  end

  def new
    @trainee = Trainee.new
  end

  def create
    @trainee = Trainee.new(trainee_params)

    if @trainee.save
      flash[:success] = 'トレーニーを登録しました。'
      redirect_to @trainee
    else
      flash.now[:danger] = 'トレーニーの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @trainee = Trainee.find(params[:id])
  end
  
  def update
    @trainee = Trainee.find(params[:id])

    if @trainee.update(trainee_params)
      flash[:success] = 'トレーニー情報は正常に更新されました'
      redirect_to @trainee
    else
      flash.now[:danger] = 'トレーニー情報は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @trainee.destroy
    flash[:success] = 'トレーニーは正常に削除されました'
    redirect_back(fallback_location: root_path)
  end
 
  private

  def trainee_params
    params.require(:trainee).permit(:name, :nickname, :email, :branch, :password, :password_confirmation, :enable, :trainer_id)
  end
end