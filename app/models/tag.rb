class Tag < ApplicationRecord
  belongs_to :user
  # タスクとの連携
  has_many :taggings, dependent: :destroy

  # validate
  validates :name, length: { maximum: 16 },presence: { message: 'エラー：タグ名を入力してください' }
  # before_destroy :delete_task

  # private

  # def delete_task
  #   if Tagging.find_by(tag_id: id).present?
  #     @task = Task.find(Tagging.find_by(tag_id: id).task_id)
  #     @task.displayed = false
  #     @task.custom_id = 1
  #     @task.destroy
  #   end
  # end
end
