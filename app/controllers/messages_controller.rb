class MessagesController < ApplicationController
  before_action :set_message,only: [:edit,:update,:destroy]

  #初期画面
  #モデルオブジェクトを作成
  def index
    @message = Message.new
    @messages = Message.all
  end
  
  #データ登録
  def create
    @message = Message.new(message_params)
    
    if @message.save
      redirect_to root_path , notice: 'メッセージを保存しました。'
    else
      #メッセージが保存できなかった場合
      @messages = Message.all
      flash.now[:alert] = "メッセージの保存に失敗しました。"
      render 'index'
    end
  end
  
  #編集画面
  def edit
  end
  
  #更新処理
  def update
    if @message.update(message_params)
      #保存成功時はIndexページへリダイレクト
      redirect_to root_path,notice:'メッセージを編集しました。'
    else
      #保存失敗時は編集画面に戻す(データは破棄)
      render 'edit'
    end
  end
  
  #削除処理
  def destroy
    @message.destroy
    redirect_to root_path, notice: 'メッセージを削除しました。'
  end
  
  private
  def message_params
    params.require(:message).permit(:name,:body)
  end
  
  def set_message
    @message = Message.find(params[:id])
  end
end
