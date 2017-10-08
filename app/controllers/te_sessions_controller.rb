class TeSessionsController < ApplicationController
  def new
  end

  def create
    email = params[:te_session][:email].downcase
    password = params[:te_session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to @trainee
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render 'new'
    end
  end

  def destroy
    session[:trainee_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  private

  def login(email, password)
    @trainee = Trainee.find_by(email: email)
    if @trainee && @trainee.authenticate(password)
      # ログイン成功
      session[:trainee_id] = @trainee.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
