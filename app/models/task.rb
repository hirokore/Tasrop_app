class Task < ApplicationRecord
  belongs_to :user
  belongs_to :custom
  # タスクステータスとの連携
  has_many :task_statuses

  # タグとの連携
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  accepts_nested_attributes_for :tags, reject_if: :all_blank, allow_destroy: true

  # validate
  validates_associated :tags
  validates :name, length: { maximum: 16 }
  validates :detail, length: { maximum: 512 }
  validates :task_time, numericality: {greater_than: 0,less_than: 24}
  
end
