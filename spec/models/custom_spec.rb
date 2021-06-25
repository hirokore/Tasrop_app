require 'rails_helper'
RSpec.describe Custom, type: :model do
  user = FactoryBot.create(:user)
  describe 'バリデーションチェック（User）' do
    it "nameがあれば有効な状態であること" do
      custom = Custom.new(user_id: user.id, title: "test01",)      
      expect(custom).to be_valid      
    end
    it "nameがない場合、無効な状態であること" do
      custom = Custom.new(user_id: user.id, title: "",)      
      expect(custom).not_to be_valid
    end
    it "nameが17文字以上があれば無効な状態であること" do
      custom = Custom.new(user_id: user.id, title: "#{"a"*17}" )      
      expect(custom).not_to be_valid
    end
  end
end
