require 'rails_helper'
RSpec.describe Tag, type: :model do
  user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
  tag = FactoryBot.create(:tag)
  describe 'バリデーションチェック（User）' do
    describe 'カラムの有無' do
      # 成功パターン
      it "nameがある場合、有効な状態であること" do
        tag = Tag.new(user_id: user.id, name: "test01",)      
        expect(tag).to be_valid      
      end
      # 失敗パターン
      it "nameがない場合、無効な状態であること" do
        tag = Tag.new(user_id: user.id, name: "",)      
        expect(tag).not_to be_valid
      end
    end
    describe '文字数制限' do
      # 成功パターン
      it "nameが16文字以内の場合、有効な状態であること" do
        tag = Tag.new(user_id: user.id, name: "#{"a"*16}" )      
        expect(tag).to be_valid
      end
      # 失敗パターン
      it "nameが17文字以上の場合、無効な状態であること" do
        tag = Tag.new(user_id: user.id, name: "#{"a"*17}" )      
        expect(tag).not_to be_valid
      end
    end
  end
end
