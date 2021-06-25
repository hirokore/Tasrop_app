require 'rails_helper'
RSpec.describe Custom, type: :model do
  user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
  describe 'バリデーションチェック（User）' do
    describe 'カラムの有無' do
      # 成功パターン
      it "nameがある場合、有効な状態であること" do
        custom = Custom.new(user_id: user.id, title: "test01",)      
        expect(custom).to be_valid      
      end
      # 失敗パターン
      it "nameがない場合、無効な状態であること" do
        custom = Custom.new(user_id: user.id, title: "",)      
        expect(custom).not_to be_valid
      end
    end
    describe '文字数制限' do
      it "nameが16文字以内の場合、有効な状態であること" do
      custom = Custom.new(user_id: user.id, title: "#{"a"*16}" )      
      expect(custom).to be_valid
      end
      it "nameが17文字以上の場合、無効な状態であること" do
        custom = Custom.new(user_id: user.id, title: "#{"a"*17}" )      
        expect(custom).not_to be_valid
      end
    end
  end
end
