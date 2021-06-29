require 'rails_helper'
RSpec.describe Message, type: :model do
  describe 'バリデーションチェック（User）' do
    describe 'カラムの有無' do
      # 成功パターン
      it "nameがある場合、有効な状態であること" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        user2 = User.find_by(email: FactoryBot.build(:second_user).email) || FactoryBot.create(:second_user)
        conversation = Conversation.create(sender_id: user.id, recipient_id: user2.id)
        message = Message.new(user_id: user.id, conversation_id: conversation.id, body: "test01",)      
        expect(message).to be_valid      
      end
      # 失敗パターン
      it "nameがない場合、無効な状態であること" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        user2 = User.find_by(email: FactoryBot.build(:second_user).email) || FactoryBot.create(:second_user)
        conversation = Conversation.create(sender_id: user.id, recipient_id: user2.id)
        message = Message.new(user_id: user.id, conversation_id: conversation.id, body: "",)      
        expect(message).not_to be_valid
      end
    end
    describe '文字数制限' do
      # 成功パターン
      it "bodyが254文字以内の場合、有効な状態であること" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        user2 = User.find_by(email: FactoryBot.build(:second_user).email) || FactoryBot.create(:second_user)
        conversation = Conversation.create(sender_id: user.id, recipient_id: user2.id)
        message = Message.new(user_id: user.id, conversation_id: conversation.id, body: "#{"a"*254}" )      
        expect(message).to be_valid
      end
      # 失敗パターン
      it "bodyが255文字以上の場合、無効な状態であること" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        user2 = User.find_by(email: FactoryBot.build(:second_user).email) || FactoryBot.create(:second_user)
        conversation = Conversation.create(sender_id: user.id, recipient_id: user2.id)
        message = Message.new(user_id: user.id, conversation_id: conversation.id, body: "#{"a"*255}" )      
        expect(message).not_to be_valid
      end
    end
  end
end
