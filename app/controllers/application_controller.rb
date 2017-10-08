class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
    include TeSessionsHelper
    include TrSessionsHelper

  private

  def require_te_logged_in
    unless te_logged_in? || tr_logged_in?
      redirect_to login_url
    end
  end
  
  def require_tr_logged_in
    unless tr_logged_in?
      redirect_to login_url
    end
  end
  
end
