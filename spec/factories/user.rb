FactoryBot.define do
  factory :user do
    name { "test01" }
    email { "test01@dic.com" }
    password {"000000" }
    password_confirmation { "000000" }
    name_tag { "1234" }
  end
  factory :second_user, class: User do
    name { "test02" }
    email { "test02@dic.com" }
    password {"000000" }
    password_confirmation { "000000" }
    name_tag { "1234" }
    uid { 1234 }
  end
  factory :user3, class: User do
    name { "test03" }
    email { "test03@dic.com" }
    password {"000000" }
    password_confirmation { "000000" }
    name_tag { "1234" }
    uid { 2345 }
  end
  factory :user4, class: User do
    name { "test04" }
    email { "test04@dic.com" }
    password {"000000" }
    password_confirmation { "000000" }
    name_tag { "1234" }
    uid { 3456 }
  end
  factory :user5, class: User do
    name { "test05" }
    email { "test05@dic.com" }
    password {"000000" }
    password_confirmation { "000000" }
    name_tag { "1234" }
    uid { 4567 }
  end
  factory :user6, class: User do
    name { "test06" }
    email { "test06@dic.com" }
    password {"000000" }
    password_confirmation { "000000" }
    name_tag { "1234" }
    uid { 5678 }
  end
end


