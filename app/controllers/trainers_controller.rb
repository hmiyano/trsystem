class TrainersController < ApplicationController
  before_action :require_tr_logged_in, only: [:show]

  def index
    @trainers = Trainer.order(created_at: :desc).page(params[:page]).per(25)

  end
  
  def show
    @trainer = Trainer.find(params[:id])
    @trainees = Trainee.all

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
    @trainer.destroy
    flash[:success] = 'トレーなーは正常に削除されました'
    redirect_back(fallback_location: root_path)
  end
  


  private

  def trainer_params
    params.require(:trainer).permit(:name, :nickname, :email, :branch, :password, :password_confirmation)
  end
end
