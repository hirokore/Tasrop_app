require 'rails_helper'
RSpec.describe User, type: :model do
  user = FactoryBot.create(:user)
  tag = FactoryBot.create(:tag)
  custom = FactoryBot.create(:custom)
  describe 'バリデーションチェック（User）' do
    it "name/detail/task_time/tag_idsがあれば有効な状態であること" do
      task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "test01", detail: "test01", task_time: "0.5")      
      expect(task).to be_valid      
    end
    it "nameがない場合、無効な状態であること" do
      task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "", detail: "test01", task_time: "0.5")            
      expect(task).not_to be_valid
    end
    it "detailがない場合、無効な状態であること" do
      task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "test01", detail: "", task_time: "0.5")            
      expect(task).not_to be_valid
    end
    it "task_timeがない場合、無効な状態であること" do
      task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "test01", detail: "test01", task_time: "")            
      expect(task).not_to be_valid
    end
    it "tag_idsがない場合、無効な状態であること" do
      task = Task.new(user_id: user.id, custom_id: custom.id, name: "test01", detail: "test01", task_time: "3.0")            
      expect(task).not_to be_valid
    end
    it "task_timeが全角な場合でも、有効な状態であること" do
      task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "test01", detail: "test01", task_time: "３")            
      expect(task).to be_valid
    end
    it "nameが17文字以上があれば無効な状態であること" do
      task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "#{"a"*17}", detail: "test01", task_time: "3.0")            
      expect(task).not_to be_valid
    end
    it "detailが513文字以上があれば無効な状態であること" do
      task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "test01", detail: "#{"a"*513}", task_time: "3.0")            
      expect(task).not_to be_valid
    end
    it "task_timeが0以下であれば無効な状態であること" do
      task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "test01", detail: "test01", task_time: "0")      
      expect(task).not_to be_valid
    end
    it "task_timeが24より大きい場合、無効な状態であること" do
      task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "test01", detail: "test01", task_time: "24.1")      
      expect(task).not_to be_valid
    end
  end
end
