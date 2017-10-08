module TeSessionsHelper
  def current_trainee
    @current_trainee ||= Trainee.find_by(id: session[:trainee_id])
  end

  def te_logged_in?
    !!current_trainee
  end
end
