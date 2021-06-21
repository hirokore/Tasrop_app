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
  validates :name, length: { maximum: 16 },presence: { message: 'エラー：タスク名を入力してください' }
  validates :detail, length: { maximum: 512 },presence: { message: 'エラー：タスク内容を入力してください' }
  validates :task_time, numericality: {greater_than: 0,less_than: 24, message: 'エラー：タスク工数は数値で入力してください'}, presence: { message: 'エラー：タスク工数は0-24時間内で入力してください' }
  validates :tag_ids, presence:  { message: 'エラー：タグを１つ以上選択してください' }

end
