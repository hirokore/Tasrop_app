require 'rails_helper'
RSpec.describe Task, type: :model do
  describe 'バリデーションチェック（User）' do
    describe 'カラムの有無' do
      # 成功パターン
      it "name/detail/task_time/tag_idsがある場合、有効な状態であること" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        tag = FactoryBot.create(:tag, user_id: user.id)
        custom = FactoryBot.create(:custom, user_id: user.id)      
        task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "test01", detail: "test01", task_time: "0.5")      
        expect(task).to be_valid      
      end
      # 失敗パターン
      it "nameがない場合、無効な状態であること" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        tag = FactoryBot.create(:tag, user_id: user.id)
        custom = FactoryBot.create(:custom, user_id: user.id)      
        task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "", detail: "test01", task_time: "0.5")            
        expect(task).not_to be_valid
      end
      it "detailがない場合、無効な状態であること" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        tag = FactoryBot.create(:tag, user_id: user.id)
        custom = FactoryBot.create(:custom, user_id: user.id)      
        task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "test01", detail: "", task_time: "0.5")            
        expect(task).not_to be_valid
      end
      it "task_timeがない場合、無効な状態であること" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        tag = FactoryBot.create(:tag, user_id: user.id)
        custom = FactoryBot.create(:custom, user_id: user.id)      
        task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "test01", detail: "test01", task_time: "")            
        expect(task).not_to be_valid
      end
      it "tag_idsがない場合、無効な状態であること" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        tag = FactoryBot.create(:tag, user_id: user.id)
        custom = FactoryBot.create(:custom, user_id: user.id)      
        task = Task.new(user_id: user.id, custom_id: custom.id, name: "test01", detail: "test01", task_time: "3.0")            
        expect(task).not_to be_valid
      end
    end
    describe '全角を半角に変更するメソッドのチェック' do
      # 成功パターンのみ
      it "task_timeが全角な場合でも、有効な状態であること" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        tag = FactoryBot.create(:tag, user_id: user.id)
        custom = FactoryBot.create(:custom, user_id: user.id)      
        task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "test01", detail: "test01", task_time: "３")            
        expect(task).to be_valid
      end
    end
    describe '文字数制限' do
      # 成功パターン
      it "nameが16文字以内の場合、有効な状態であること" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        tag = FactoryBot.create(:tag, user_id: user.id)
        custom = FactoryBot.create(:custom, user_id: user.id)      
        task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "#{"a"*16}", detail: "test01", task_time: "3.0")            
        expect(task).to be_valid
      end
      it "detailが512文字以内の場合、有効な状態であること" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        tag = FactoryBot.create(:tag, user_id: user.id)
        custom = FactoryBot.create(:custom, user_id: user.id)      
        task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "test01", detail: "#{"a"*512}", task_time: "3.0")            
        expect(task).to be_valid
      end
      it "task_timeが0より大きく24より小さい場合、有効な状態であること(1をテスト)" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        tag = FactoryBot.create(:tag, user_id: user.id)
        custom = FactoryBot.create(:custom, user_id: user.id)      
        task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "test01", detail: "test01", task_time: "1")      
        expect(task).to be_valid
      end
      it "task_timeが0より大きく24より小さい場合、有効な状態であること(23をテスト)" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        tag = FactoryBot.create(:tag, user_id: user.id)
        custom = FactoryBot.create(:custom, user_id: user.id)      
        task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "test01", detail: "test01", task_time: "23")      
        expect(task).to be_valid
      end
      # 失敗パターン
      it "nameが17文字以上の場合、無効な状態であること" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        tag = FactoryBot.create(:tag, user_id: user.id)
        custom = FactoryBot.create(:custom, user_id: user.id)      
        task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "#{"a"*17}", detail: "test01", task_time: "3.0")            
        expect(task).not_to be_valid
      end
      it "detailが513文字以上の場合、無効な状態であること" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        tag = FactoryBot.create(:tag, user_id: user.id)
        custom = FactoryBot.create(:custom, user_id: user.id)      
        task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "test01", detail: "#{"a"*513}", task_time: "3.0")            
        expect(task).not_to be_valid
      end
      it "task_timeが0以下の場合、無効な状態であること" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        tag = FactoryBot.create(:tag, user_id: user.id)
        custom = FactoryBot.create(:custom, user_id: user.id)      
        task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "test01", detail: "test01", task_time: "0")      
        expect(task).not_to be_valid
      end
      it "task_timeが24より大きい場合、無効な状態であること" do
        user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
        tag = FactoryBot.create(:tag, user_id: user.id)
        custom = FactoryBot.create(:custom, user_id: user.id)      
        task = Task.new(user_id: user.id, tag_ids: [tag.id], custom_id: custom.id, name: "test01", detail: "test01", task_time: "24.1")      
        expect(task).not_to be_valid
      end
    end
  end
end
