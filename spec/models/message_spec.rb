require 'rails_helper'
RSpec.describe Message, type: :model do
  user = FactoryBot.create(:user)
  user2 = FactoryBot.create(:second_user)
  conversation = FactoryBot.create(:conversation)
  message = FactoryBot.create(:message)
  describe 'バリデーションチェック（User）' do
    it "nameがあれば有効な状態であること" do
      message = Message.new(user_id: user.id, conversation_id: conversation.id, body: "test01",)      
      expect(message).to be_valid      
    end
    it "nameがない場合、無効な状態であること" do
      message = Message.new(user_id: user.id, conversation_id: conversation.id, body: "",)      
      expect(message).not_to be_valid
    end
    it "bodyが255文字以上があれば無効な状態であること" do
      message = Message.new(user_id: user.id, conversation_id: conversation.id, body: "#{"a"*255}" )      
      expect(message).not_to be_valid
    end
  end
end
