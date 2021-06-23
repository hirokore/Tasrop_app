FactoryBot.define do
  factory :user do
    name { "test01" }
    email { "test01@dic.com" }
    password {"000000" }
    password_confirmation { "000000" }
    name_tag { "1234" }
  end
end
