class TraineesController < ApplicationController
  before_action :require_te_logged_in, only: [:show]

  def show
    @trainee = Trainee.find(params[:id])
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

  private

  def trainee_params
    params.require(:trainee).permit(:name, :email, :branch, :password, :password_confirmation)
  end
end
