class RoomsController < ApplicationController
  #チャットルーム一覧ページ（サイドバーのみ）
  def index
  end

  #新規ルーム作成ページ
  def new
    @room = Room.new
  end

  #新規ルーム作成時のデータ保存
  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render action: :new
    end
  end

  #チャットルームの削除
  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to root_path
  end 

  private

  def room_params
    params.require(:room).permit(:name, user_ids: [] )
  end
end
