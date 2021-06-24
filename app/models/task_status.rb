class TaskStatus < ApplicationRecord
  # 写真利用機能
  mount_uploader :picture, ImageUploader
  # validate
  validates :comment, length: { maximum: 254 }

  belongs_to :user
  belongs_to :task
end
