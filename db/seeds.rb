# Userシード
10.times do |n|
  role = "user"
  uid = User.create_unique_string
  last_target = "#{n}年後に企業すること！！"
  name = "hiro#{n}"
  email = "hiro#{n}@dic.com"
  password = "000000"
  name_tag = User.name_tag
  if n == 0
    User.create!(name_tag: name_tag, uid: uid, role: "admin", name: "administrator", email: "yama@dic.com", password: password, password_confirmation: password)
  else
    User.create!(name_tag: name_tag, uid: uid, role: role, name: name, email: email, password: password, password_confirmation: password)
  end
end

# マイタスクデフォルト
Custom.create!(user_id: 1, title: "タスクデフォルト設定用", displayed: false) 

# デモ用タグ
Tag.create!(user_id: 1, name: "IT学習")
Tag.create!(user_id: 1, name: "読書")
Tag.create!(user_id: 2, name: "戦闘力")

# デモ用タスク
Task