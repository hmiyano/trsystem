class TrainersController < ApplicationController
#  before_action :require_tr_logged_in, only: [:show]

  def index
    
    if admin_logged_in?
      if params[:branchname]
        @trainers = Trainer.where(branch: params[:branchname]).order(created_at: :asc).page(params[:page]).per(25)
      else
        @trainers = Trainer.order(created_at: :asc).page(params[:page]).per(25)
      end      
    elsif tr_logged_in?
      if params[:branchname]
         @trainers = tr_enable.where(branch: params[:branchname]).order(created_at: :asc).page(params[:page]).per(25)
      else
        @trainers = tr_enable.order(created_at: :asc).page(params[:page]).per(25)
      end
    end
  end
  
  def show
    @trainer = Trainer.find(params[:id])
    @trainees = Trainee.all
#    @trainee = Trainee.find(params[:id])
  end

  def new
    @trainer = Trainer.new
  end

  def create
    @trainer = Trainer.new(trainer_params)

    if @trainer.save
      flash[:success] = 'トレーナーを登録しました。'
      redirect_to @trainer
    else
      flash.now[:danger] = 'トレーナーの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @trainer = Trainer.find(params[:id])
  end
  
  def update
    @trainer = Trainer.find(params[:id])
    if @trainer.update(trainer_params)
      flash[:success] = 'トレーナー情報は正常に更新されました'
      redirect_to @trainer
    else
      flash.now[:danger] = 'トレーナー情報は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @trainer = Trainer.find(params[:id])
    @trainer.destroy
    flash[:success] = 'トレーナーは正常に削除されました'
    redirect_to trainers_path
  end
  


  private

  def trainer_params
    params.require(:trainer).permit(:grade, :name, :nickname, :email, :branch, :password, :password_confirmation, :enable, :slack)
  end
end
