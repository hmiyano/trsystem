class AdminsController < ApplicationController
  before_action :require_admin_logged_in, only: [:show]

  def show
    @admin = Admin.find(params[:id])
  end

  def new
  end

  def create
  end
end
