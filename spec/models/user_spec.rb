require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'バリデーションチェック（User）' do
    describe 'カラムの有無' do
      # 成功パターン
      it "name/email/password(確認も)/name_tagがある場合、有効な状態であること" do
        user = User.new(name: "test01", email: "test01@dic.com", password: "000000", password_confirmation: "000000", name_tag: "0000")
        expect(user).to be_valid
      end
      # 失敗パターン
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
    describe '文字数制限' do
      # 成功パターン
      it "nameが32文字以内の場合、有効な状態であること" do
        user = User.new(name: "#{"a"*32}", email: "test01@dic.com", password: "000000", password_confirmation: "000000", name_tag: "0000")
        expect(user).to be_valid
      end
      it "emailが254文字以内の場合、有効な状態であること" do
        user = User.new(name: "test01", email: "#{"a"*246}@dic.com", password: "000000", password_confirmation: "000000", name_tag: "0000")
        expect(user).to be_valid
      end
      # 失敗パターン
      it "nameが33文字以上の場合、無効な状態であること" do
        user = User.new(name: "#{"a"*33}", email: "test01@dic.com", password: "000000", password_confirmation: "000000", name_tag: "0000")
        expect(user).not_to be_valid
      end
      it "emailが255文字以上の場合、無効な状態であること" do
        user = User.new(name: "test01", email: "#{"a"*247}@dic.com", password: "000000", password_confirmation: "000000", name_tag: "0000")
        expect(user).not_to be_valid
      end
    end
    describe 'name_tag検索のテスト' do
      # 成功パターン
      it "存在しているネームタグの検索が可能なこと" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        expect(User.find_by(name_tag: "1234")).to eq user
      end
      # 失敗パターン
      it "存在していないネームタグの検索が不可能なこと" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        expect(User.find_by(name_tag: "4321")).not_to eq user
      end
    end
  end
end