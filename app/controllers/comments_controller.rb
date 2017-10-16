class CommentsController < ApplicationController
  
  def create
    @comment = current_trainee.comments.build(comment_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました'
      redirect_to root_url
    else
      @comments = current_trainee.comments.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'コメントの投稿に失敗しました'
      render 'toppages/index'
    end
  end

  def destroy
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
  
end
