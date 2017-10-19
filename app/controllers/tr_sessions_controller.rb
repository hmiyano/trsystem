class TrSessionsController < ApplicationController
  def new
  end

  def create
    email = params[:tr_session][:email].downcase
    password = params[:tr_session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render 'new'
    end
  end

  def destroy
    session[:trainer_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  private

  def login(email, password)
    @trainer = Trainer.find_by(email: email)
    if @trainer && @trainer.authenticate(password)
      # ログイン成功
      session[:trainer_id] = @trainer.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end


