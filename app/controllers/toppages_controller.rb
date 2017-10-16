class ToppagesController < ApplicationController
#  def index
#    if te_logged_in? || tr_logged_in?
#      @checklist = checklist.build  # form_for 用
#      @checklists = checklists.order('created_at DESC').page(params[:page])
#    end
#  end

  def index
    @checklists = Checklist.order('updated_at DESC')
    @trainees = Trainee.all

    if te_logged_in?
      @trainee = current_trainee
      @comment = current_trainee.comments.build
      @comments = current_trainee.comments.order('created_at DESC').page(params[:page]).per(10)
    end
  end
end
