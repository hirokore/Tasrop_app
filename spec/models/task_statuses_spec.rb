require 'rails_helper'
RSpec.describe Task, type: :model do
  user = FactoryBot.create(:user)
  tag = FactoryBot.create(:tag)
  custom = FactoryBot.create(:custom)
  task = FactoryBot.create(:task)
  describe 'バリデーションチェック（User）' do
    it "user_id/task_idがあれば有効な状態であること(task_statusは基本デフォルトのため、これだけ実施)" do
      task_status = TaskStatus.new(user_id: user.id, task_id: task.id)      
      expect(task_status).to be_valid      
    end
    it "commentが255文字以上があれば無効な状態であること" do
      task_status = TaskStatus.new(user_id: user.id, task_id: task.id, comment: "#{"a"*255}")      
      expect(task_status).not_to be_valid      
    end
  end
end
