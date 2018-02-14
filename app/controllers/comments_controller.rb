class CommentsController < ApplicationController
#  before_action :correct_trainee, only: [:destroy]
  
  def create
    @comment = current_trainee.comments.build(comment_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました'
      

      notifier = Slack::Notifier.new('https://hooks.slack.com/services/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', channel: "#trsystem") #事前準備で取得したWebhook URL
      notifier.ping ">" + current_trainee.branch + "所属の" + current_trainee.nickname + "さんがトレーニングシートを更新しました。専任トレーナーの" + "#{Trainer.find(current_trainee.trainer_id).name}" + "さんは確認をお願いします <#{request.referer}>"
      
      notifier = Slack::Notifier.new('https://hooks.slack.com/services/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', channel: "#{Trainer.find(current_trainee.trainer_id).slack}") #事前準備で取得したWebhook URL
      notifier.ping ">" + "あなたが専任トレーナーの、" + current_trainee.branch + "所属の" + current_trainee.nickname + "さんがトレーニングシートを更新しました。確認をお願いします <#{request.referer}>"
      
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
      
      notifier = Slack::Notifier.new('https://hooks.slack.com/services/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', channel: "#{Trainee.find(@comment.trainee_id).slack}") #事前準備で取得したWebhook URL
      notifier.ping ">" + current_trainer.nickname + "さんが、あなたのトレーニングシートを更新しました！ <#{request.referer}>"

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
#      unless @comment
#        redirect_to root_url
      @comment.destroy
      flash[:danger] = 'コメントを削除しました'
      redirect_back(fallback_location: root_path)
#      end
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
