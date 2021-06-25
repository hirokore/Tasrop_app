require 'rails_helper'
RSpec.describe Contact, type: :model do
  describe 'バリデーションチェック（User）' do
    describe 'カラムの有無' do
      # 成功パターン
      it "name/detail/task_time/tag_idsががある場合、有効な状態であること" do
        contact = Contact.new(name: "test01", title: "test01", email: "test01@dic.com", content: "test01")      
        expect(contact).to be_valid      
      end
      # 失敗パターン
      it "nameがない場合、無効な状態であること" do
        contact = Contact.new(name: "", title: "test01", email: "test01@dic.com", content: "test01")      
        expect(contact).not_to be_valid      
      end
      it "titleがない場合、無効な状態であること" do
        contact = Contact.new(name: "test01", title: "", email: "test01@dic.com", content: "test01")      
        expect(contact).not_to be_valid      
      end
      it "emailがない場合、無効な状態であること" do
        contact = Contact.new(name: "test01", title: "test01", email: "", content: "test01")      
        expect(contact).not_to be_valid      
      end
      it "contentがない場合、無効な状態であること" do
        contact = Contact.new(name: "test01", title: "test01", email: "test01@dic.com", content: "")      
        expect(contact).not_to be_valid      
      end
    end
    describe '文字数制限' do
      # 成功パターン
      it "nameが16文字以内の場合、有効な状態であること" do
        contact = Contact.new(name: "#{"a"*16}", title: "test01", email: "test01@dic.com", content: "test01")      
        expect(contact).to be_valid      
      end
      it "titleが32文字以内の場合、有効な状態であること" do
        contact = Contact.new(name: "test01", title: "#{"a"*32}", email: "test01@dic.com", content: "test01")      
        expect(contact).to be_valid      
      end
      it "emailが254文字以内の場合、有効な状態であること" do
        contact = Contact.new(name: "test01", title: "test01", email: "#{"a"*254}", content: "test01")      
        expect(contact).to be_valid      
      end
      it "contentが254文字以内の場合、有効な状態であること" do
        contact = Contact.new(name: "test01", title: "test01", email: "test01@dic.com", content: "#{"a"*254}")      
        expect(contact).to be_valid      
      end
      # 失敗パターン
      it "nameが17文字以上の場合、無効な状態であること" do
        contact = Contact.new(name: "#{"a"*17}", title: "test01", email: "test01@dic.com", content: "test01")      
        expect(contact).not_to be_valid      
      end
      it "titleが33文字以上の場合、無効な状態であること" do
        contact = Contact.new(name: "test01", title: "#{"a"*33}", email: "test01@dic.com", content: "test01")      
        expect(contact).not_to be_valid      
      end
      it "emailが255文字以上の場合、無効な状態であること" do
        contact = Contact.new(name: "test01", title: "test01", email: "#{"a"*255}", content: "test01")      
        expect(contact).not_to be_valid      
      end
      it "contentが255文字以上の場合、無効な状態であること" do
        contact = Contact.new(name: "test01", title: "test01", email: "test01@dic.com", content: "#{"a"*255}")      
        expect(contact).not_to be_valid      
      end
    end
  end
end
