class ToppagesController < ApplicationController

  def index
    @checklists = Checklist.order('updated_at DESC')
    @trainees = Trainee.all
  end
end
