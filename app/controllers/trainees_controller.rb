class TraineesController < ApplicationController
  before_action :require_te_logged_in, only: [:show]

  def index
    @trainees = Trainee.order(created_at: :desc).page(params[:page]).per(25)
  end
  
  def show
    @trainee = Trainee.find(params[:id])
    @checklists = Checklist.all
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
    params.require(:trainee).permit(:name, :email, :branch, :password, :password_confirmation)
  end
end
