class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
    include TeSessionsHelper
    include TrSessionsHelper
    include AdminSessionsHelper
    
  private

  def require_te_logged_in
    unless te_logged_in? || tr_logged_in?
      redirect_to te_login_url
    end
  end
  
  def require_tr_logged_in
    unless tr_logged_in?
      redirect_to tr_login_url
    end
  end
  
  def require_admin_logged_in
    unless admin_logged_in?
      redirect_to admin_login_url
    end
  end
  
  def te_enable
    Trainee.where(enable: true) 
  end
  
  def tr_enable
    Trainer.where(enable: true) 
  end
end
