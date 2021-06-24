FactoryBot.define do
  factory :message do
    user_id { 1 }
    conversation_id { 1 }
    body { "test01" }
  end
end
