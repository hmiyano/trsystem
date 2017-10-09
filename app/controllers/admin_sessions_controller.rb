class AdminSessionsController < ApplicationController
  def new
  end

  def create
    email = params[:admin_session][:email].downcase
    password = params[:admin_session][:password]
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to @admin
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      render 'new'
    end
  end

  def destroy
    session[:admin_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  private

  def login(email, password)
    @admin = Admin.find_by(email: email)
    if @admin && @admin.authenticate(password)
      # ログイン成功
      session[:admin_id] = @admin.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
end
