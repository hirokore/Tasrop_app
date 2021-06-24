require 'rails_helper'
RSpec.describe Contact, type: :model do
  describe 'バリデーションチェック（User）' do
    it "name/detail/task_time/tag_idsがあれば有効な状態であること" do
      contact = Contact.new(name: "test01", title: "test01", email: "test01@dic.com", content: "test01")      
      expect(contact).to be_valid      
    end
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
    it "nameが17文字以上があれば無効な状態であること" do
      contact = Contact.new(name: "#{"a"*17}", title: "test01", email: "test01@dic.com", content: "test01")      
      expect(contact).not_to be_valid      
    end
    it "titleが33文字以上があれば無効な状態であること" do
      contact = Contact.new(name: "test01", title: "#{"a"*33}", email: "test01@dic.com", content: "test01")      
      expect(contact).not_to be_valid      
    end
    it "emailが255文字以上があれば無効な状態であること" do
      contact = Contact.new(name: "test01", title: "test01", email: "#{"a"*255}", content: "test01")      
      expect(contact).not_to be_valid      
    end
    it "contentが255文字以上があれば無効な状態であること" do
      contact = Contact.new(name: "test01", title: "test01", email: "test01@dic.com", content: "#{"a"*255}")      
      expect(contact).not_to be_valid      
    end
  end
end
