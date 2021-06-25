class User < ApplicationRecord
  # 写真利用機能
  mount_uploader :image, ImageUploader

  # 繋がり機能
  has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # タスクとの連携
  has_many :tasks, dependent: :destroy

  # マイタスクカスタマイズ機能
  has_many :customs, dependent: :destroy

  # タスクステータスとの連携
  has_many :task_statuses, dependent: :destroy

  # タグとの連携
  has_many :tags, dependent: :destroy

  # メンターとの連携
  has_many :mentors, dependent: :destroy

  # デバイス関連
  devise  :database_authenticatable, :registerable,:recoverable, :rememberable,
          :validatable, :trackable,:omniauthable, omniauth_providers: %i(google facebook)

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  
  # validate
  validates :name, length: { maximum: 32 },presence: { message: 'エラー：名前を入力してください' }
  validates :email, length: { maximum: 254 },presence: { message: 'エラー：メールアドレスを入力してください' }
  validates :password, presence: { message: 'エラー：パスワードを入力してください' }
  validates :password_confirmation, presence: { message: 'エラー：パスワードの再入力をしてください' }
  validates :name_tag, presence: true
  
  # 一般ユーザーの役割をデフォルト追加するメソッド
  def set_default_role
    self.role ||= :user
  end

  # ゲストログイン用メソッド
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = "000000"
      user.password_confirmation = "000000"
      user.name = 'ゲストユーザー'
      user.name_tag = name_tag
      user.uid = create_unique_string
      user.vip!
      # 通常ログインができるように
    end
  end
    # テスト用管理者ログイン用メソッド
    def self.guest_admin
      find_or_create_by!(email: 'guest_admin@example.com') do |user|
        user.password = "000000"
        user.password_confirmation = "000000"
        user.name = 'ゲスト管理者'
        user.name_tag = name_tag
        user.uid = create_unique_string
        user.admin!
        # 通常ログインができるように
      end
    end
  # uid作成メソッド
  def self.create_unique_string
    SecureRandom.uuid
  end
  # 外部から取得したユーザー情報を元に、このアプリで使用するユーザーを作成する
  def self.find_for_oauth(auth)
    user = User.find_by(email: auth.info.email)
    unless user
      name = "SNSログインユーザー" unless auth.info.name
      user = User.new(email: auth.info.email,
                      name: name,
                      name_tag: name_tag,
                      provider: auth.provider,
                      uid:      auth.uid,
                      password: "000000",
                      password_confirmation: "000000"
      )
      # password: Devise.friendly_token[0, 20] 本当はこれを使いたいが、メール機能がないためパス変更ができないので省略
    end
    user.save
    user
  end
  #指定のユーザをフォローする
  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end
  #フォローしているかどうかを確認する
  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end
  #指定のユーザのフォローを解除する
  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  #検索用にネームタグを追加
  def self.name_tag
    rand(1..9999)
  end
  # パスワード入力なしでユーザー情報を更新
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

end
