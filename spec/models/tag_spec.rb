require 'rails_helper'
RSpec.describe Tag, type: :model do
  user = FactoryBot.create(:user)
  tag = FactoryBot.create(:tag)
  describe 'バリデーションチェック（User）' do
    it "nameがあれば有効な状態であること" do
      tag = Tag.new(user_id: user.id, name: "test01",)      
      expect(tag).to be_valid      
    end
    it "nameがない場合、無効な状態であること" do
      tag = Tag.new(user_id: user.id, name: "",)      
      expect(tag).not_to be_valid
    end
    it "nameが17文字以上があれば無効な状態であること" do
      tag = Tag.new(user_id: user.id, name: "#{"a"*17}" )      
      expect(tag).not_to be_valid
    end
  end
end
