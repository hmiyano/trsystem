class AdminsController < ApplicationController
  before_action :require_admin_logged_in, only: [:show]

  def index
    @admins = Admin.order(created_at: :desc).page(params[:page]).per(25)
  end
  
  def show
    @admin = Admin.find(params[:id])
    @checklists = Checklist.all

  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    
    if @admin.save
      flash[:success] = '管理者を登録しました'
      redirect_to @admin
    else
      flash.now[:danger] = '管理者を登録できませんでした'
      render :new
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end
  
  def update
    @admin = Admin.find(params[:id])
    if @admin.update(admin_params)
      flash[:success] = '管理者情報は正常に更新されました'
      redirect_to @admin
    else
      flash.now[:danger] = '管理者情報は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    flash[:success] = '管理者は正常に削除されました'
    render :new   
  end
  
  private
  
  # Strong Parameter
  def admin_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end

end
