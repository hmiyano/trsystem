class TraineesController < ApplicationController
#  before_action :require_te_logged_in, only: [:show]

  def index

    # ADMIN
    if admin_logged_in?
      if params[:branchname]
        @trainees = Trainee.where(branch: params[:branchname]).order(created_at: :asc).page(params[:page]).per(25)
      else
        @trainees = Trainee.order(created_at: :asc).page(params[:page]).per(25)
      end  
    # TRAINER
    elsif tr_logged_in?
      if current_trainer.grade == "PG1" || current_trainer.grade == "PG2"
        if params[:branchname]
           @trainees = Trainee.where(enable: true).where(grade: "PG1").where(branch: params[:branchname]).order(created_at: :asc).page(params[:page]).per(25)
        else
          @trainees = Trainee.where(enable: true).where(grade: "PG1").order(created_at: :asc).page(params[:page]).per(25)
        end
      elsif current_trainer.grade == "PG3" || current_trainer.grade == "G1"
        if params[:branchname]
           @trainees = Trainee.where(enable: true).where("(grade = ?) OR (grade = ?) OR (grade = ?) OR (grade = ?)", "PG1", "PG2", "PG3", "G1A").where(branch: params[:branchname]).order(created_at: :asc).page(params[:page]).per(25)
        else
          @trainees = Trainee.where(enable: true).where("(grade = ?) OR (grade = ?) OR (grade = ? OR (grade = ?))", "PG1", "PG2", "PG3", "G1A").order(created_at: :asc).page(params[:page]).per(25)
        end              
      elsif current_trainer.grade == "G2"
        if params[:branchname]
           @trainees = Trainee.where(enable: true).where("(grade = ?) OR (grade = ?) OR (grade = ?) OR (grade = ?)", "PG1", "PG2", "PG3", "G1").where(branch: params[:branchname]).order(created_at: :asc).page(params[:page]).per(25)
        else
          @trainees = Trainee.where(enable: true).where("(grade = ?) OR (grade = ?) OR (grade = ?) OR (grade = ?)", "PG1", "PG2", "PG3", "G1").order(created_at: :asc).page(params[:page]).per(25)
        end  
      else
        if params[:branchname]
           @trainees = te_enable.where(branch: params[:branchname]).order(created_at: :asc).page(params[:page]).per(25)
        else
          @trainees = te_enable.order(created_at: :asc).page(params[:page]).per(25)
        end        
      end
    end
    

    
  end
  
  def show
    
    @trainee = Trainee.find(params[:id])

    if te_logged_in?
      @trainee = current_trainee
      @comment = @trainee.comments.build
      @comments = @trainee.comments.order('created_at DESC').page(params[:comments_page]).per(3)
    elsif tr_logged_in?
      @trainer = current_trainer
      @comment = @trainee.comments.build
      @comments = @trainee.comments.order('created_at DESC').page(params[:comments_page]).per(3)
    else
      @comments = @trainee.comments.order('created_at DESC').page(params[:comments_page]).per(3)
    end
    
    # @trainee の対象チェックリストのみを表示する
    allow_grades = $all_grades.select { |permit| @trainee.try(permit) }
    allow_grades_query = allow_grades.map { |a| "#{a.to_s} = true"}.join(" OR ")
    sortedlist = Checklist.where(allow_grades_query)  

    # progress 確認用
    @progresslists = Checklist.where(allow_grades_query)  unless Checklist.where(allow_grades_query) == "[]"

    
    if  params[:chapname] == ""
      params[:chapname] = session[:chap]
    end    
    
    if  params[:selfcheck] == ""
      params[:selfcheck] = session[:self]
    end
    
    if  params[:master] == ""
      params[:master] = session[:master]
    end

    if params[:chapname] == "全て"
      session[:chap] = params[:chapname]
    elsif params[:chapname]      
      session[:chap] = params[:chapname]
      sortedlist = sortedlist.where(chapter: session[:chap])
    elsif session[:chap].nil? || session[:chap] == "全て" || session[:chap] == ""

    else
      sortedlist = sortedlist.where(chapter: session[:chap])
    end
    

    if params[:selfcheck] == "全て"
      session[:self] = params[:selfcheck]
    elsif params[:selfcheck] == "チェックなし"
  #    session[:self] = params[:selfcheck]
  #    sortedlist = sortedlist.joins(:te_checks).where("te_checks.type = 'First' = null")
    elsif params[:selfcheck]      
      session[:self] = params[:selfcheck]
      sortedlist = sortedlist.joins(:te_checks).where("te_checks.type = '#{params[:selfcheck]}' and te_checks.trainee_id = #{@trainee.id}")
    elsif session[:self].nil? || session[:self] == "全て" || session[:self] == "チェックなし"

    else
      sortedlist = sortedlist.joins(:te_checks).where("te_checks.type = '#{params[:selfcheck]}' and te_checks.trainee_id = #{@trainee.id}")
    end
    
    if params[:master] == "全て"
      session[:master] = params[:master]
    elsif params[:master] == 'マスターしている'
      session[:master] = params[:master]
      sortedlist = sortedlist.joins(:tr_checks).where("tr_checks.trainee_id = #{@trainee.id}")
    elsif  params[:master] == 'マスター待ち'
      session[:master] = params[:master]
      sortedlist = sortedlist
                    .joins("left join te_checks on te_checks.checklist_id = checklists.id")
                    .joins("left join tr_checks on tr_checks.checklist_id = checklists.id and tr_checks.trainee_id = #{@trainee.id}")
                    .where("te_checks.type = 'Third'").where("te_checks.trainee_id = #{@trainee.id}")
                    .where("tr_checks.checklist_id is null")
    elsif session[:master].nil? || session[:master] == "全て" || session[:master] == "ALL"

    else

    end    

    @checklists = sortedlist.order(created_at: :asc).page(params[:check_page]).per(25)

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
    @trainee = Trainee.find(params[:id])
    @trainee.destroy
    flash[:success] = 'トレーニーは正常に削除されました'
    redirect_to trainees_path
  end
 
  private

  def trainee_params
    params.require(:trainee).permit(:name, :nickname, :email, :branch, :password, :password_confirmation, :enable, :trainer_id, :pg1ac, :pg1ak, :pg1bc, :pg1bk, :pg2ac, :pg2ak, :pg2bc, :pg2bk, :pg2cc, :pg2ck, :pg3a, :pg3b, :pg3c, :g1a, :g1b, :g1c, :g1d, :g2a, :g2b, :g2c, :g2d, :grade)
  end
end