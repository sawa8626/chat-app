require 'rails_helper'

RSpec.describe "チャットルームの削除機能", type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
    @message = FactoryBot.build(:message)
  end

  it 'チャットルームを削除すると、関連するメッセージが全て削除されていること' do
    #　サインインする
    sign_in(@room_user.user)

    #　作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)

    #　メッセージ情報を5つDBに追加する
    @message.user = @room_user.user
    @message.room = @room_user.room
    5.times do |i|
      fill_in 'type a message', with: @message.content
      click_on('送信')
    end

    #　「チャットを終了する」ボタンをクリックすることで、作成した5つのメッセージが削除されていることを期待する
    expect{
      click_on('チャットを終了する')
    }.to change{ @room_user.room.messages.count }.by(-5)

    #　ルートページに遷移されることを期待する
    expect(current_path).to eq root_path
  end
end
