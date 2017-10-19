class CommentsController < ApplicationController
#  before_action :correct_trainee, only: [:destroy]
  
  def create
    @comment = current_trainee.comments.build(comment_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました'
      redirect_back(fallback_location: root_path)
    else
      @comments = current_trainee.comments.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'コメントの投稿に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      flash[:success] = 'コメントは正常に更新されました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = 'コメントは更新されませんでした'
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    
    if admin_logged_in?
      @comment = Comment.find_by(id: params[:id])
      @comment.destroy
      flash[:danger] = 'コメントを削除しました'
      redirect_back(fallback_location: root_path)
    else
      @comment = current_trainee.comments.find_by(id: params[:id])
      unless @comment
        redirect_to root_url
      @comment.destroy
      flash[:danger] = 'コメントを削除しました'
      redirect_back(fallback_location: root_path)
      end
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content, :reply, :trainer_id)
  end
  
  def correct_trainee
    @comment = current_trainee.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
  
end
