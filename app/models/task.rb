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
  validates :tag_ids, presence:  { message: 'エラー：タグは１つ以上の選択が必須です' }

  # タスク作成前後、関連メソッド発火
  # before_create :custom_set

  # 全角を半角に強制転換
  def task_time=(string)
    string.tr!('０-９', '0-9') if string.is_a?(String)
    super(string)
  end

  private

  # def custom_set
  #   @task.custom_id = 1
  #   @task.user_id = current_user.id
  # end
  
end
