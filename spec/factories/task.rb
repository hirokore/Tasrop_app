FactoryBot.define do
  factory :task do
    user_id { 1 }
    custom_id { 1 }
    name { "test01" }
    detail { "test01" }
    task_time { 3.0 }
    tag_ids { [1] }
  end
end

