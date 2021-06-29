class Contact < ApplicationRecord
  # validate
  validates :name, length: { maximum: 16 }, presence: true
  validates :title, length: { maximum: 32 }, presence: true
  validates :email, length: { maximum: 254 }, presence: true
  validates :content, length: { maximum: 254 },presence: true

  # 問い合わせ作成後「to_slack」発火
  after_create :to_slack

  # 他でも「slack通知」が使いたかったら以下クラスメソッドを使用
  # def self.to_slack(name,email,title,content)
  #   notifier = Slack::Notifier.new(
  #     ENV['WEBHOOK_URL'],
  #     channel: '#' + ENV['CHANNEL']
  #   )
  #   slack_message = "名前:#{name}\r\nアドレス：#{email}\r\n件名：#{title}\r\n件名：#{content}"
  #   notifier.ping "【お問い合わせ】\r\n#{slack_message}"
  # end

  private

  # slack通知インスタンスメソッド
  def to_slack
    notifier = Slack::Notifier.new(
      ENV['WEBHOOK_URL'],
      channel: '#' + ENV['CHANNEL']
    )
    slack_message = "名前:#{name}\r\nアドレス：#{email}\r\n件名：#{title}"
    notifier.ping "【お問い合わせ】\r\n#{slack_message}"
  end

end
