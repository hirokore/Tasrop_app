class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  
  # validate
  validates_presence_of :body, :conversation_id, :user_id
  validates :body, length: { maximum: 254 }

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end