require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'バリデーションチェック（User）' do
    it "name/email/password(確認も)/name_tagがあれば有効な状態であること" do
      user = User.new(name: "test01", email: "test01@dic.com", password: "000000", password_confirmation: "000000", name_tag: "0000")
      expect(user).to be_valid
    end
    it "nameがない場合、無効な状態であること" do
      user = User.new(name: "", email: "test01@dic.com", password: "000000", password_confirmation: "000000", name_tag: "0000")
      expect(user).not_to be_valid
    end
    it "emailがない場合、無効な状態であること" do
      user = User.new(name: "test01", email: "", password: "000000", password_confirmation: "000000", name_tag: "0000")
      expect(user).not_to be_valid
    end
    it "passwordがない場合、無効な状態であること" do
      user = User.new( name: "test01", email: "test01@dic.com", password: "", password_confirmation: "000000", name_tag: "0000")
      expect(user).not_to be_valid
    end
    it "password_confirmationがない場合、無効な状態であること" do
      user = User.new( name: "test01", email: "test01@dic.com", password: "000000", password_confirmation: "", name_tag: "0000")
      expect(user).not_to be_valid
    end
    it "name_tagがない場合、無効な状態であること" do
      user = User.new( name: "test01", email: "test01@dic.com", password: "000000", password_confirmation: "000000", name_tag: "")
      expect(user).not_to be_valid
    end
  end
  describe 'name_tag検索のテスト' do
    before(:each) do
      @user = create(:user) #ここで定義
    end
    it "name_tagの検索が可能なこと" do
      expect(User.find_by(name_tag: "1234")).to eq @user
    end
  end
end