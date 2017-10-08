class TrainersController < ApplicationController
  def show
    @trainer = Trainer.find(params[:id])
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

  private

  def trainer_params
    params.require(:trainer).permit(:name, :email, :branch, :password, :password_confirmation)
  end
end
