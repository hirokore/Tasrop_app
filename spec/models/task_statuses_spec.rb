require 'rails_helper'
RSpec.describe Task, type: :model do
  user = User.find_by(email: FactoryBot.build(:user).email) || FactoryBot.create(:user)
  tag = FactoryBot.create(:tag)
  custom = FactoryBot.create(:custom)
  task = FactoryBot.create(:task)
  describe 'バリデーションチェック（User）' do
    describe 'カラムの有無' do
      # 成功パターンのみ
      it "user_id/task_idがあれば有効な状態であること(task_statusはデフォルト設定があるため、作成できるかだけテスト)" do
        task_status = TaskStatus.new(user_id: user.id, task_id: task.id)      
        expect(task_status).to be_valid      
      end
    end
    describe '文字数制限' do
      # 成功パターン
      it "commentが254文字以内の場合、有効な状態であること" do
        task_status = TaskStatus.new(user_id: user.id, task_id: task.id, comment: "#{"a"*254}")      
        expect(task_status).to be_valid      
      end
      # 失敗パターン
      it "commentが255文字以上があれば無効な状態であること" do
        task_status = TaskStatus.new(user_id: user.id, task_id: task.id, comment: "#{"a"*255}")      
        expect(task_status).not_to be_valid      
      end
    end
  end
end
