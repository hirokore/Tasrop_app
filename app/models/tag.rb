class Tag < ApplicationRecord
  belongs_to :user
  # タスクとの連携
  has_many :taggings, dependent: :destroy

  # validate
  validates :name, length: { maximum: 16 },presence: { message: 'エラー：タグ名を入力してください' }

end
