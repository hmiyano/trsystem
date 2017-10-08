module TrSessionsHelper
  def current_trainer
    @current_trainer ||= Trainer.find_by(id: session[:trainer_id])
  end

  def tr_logged_in?
    !!current_trainer
  end
end
