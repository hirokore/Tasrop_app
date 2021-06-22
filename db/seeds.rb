# Userシード
10.times do |n|
  role = "user"
  uid = User.create_unique_string
  last_target = "#{n-1}年後に企業すること！！"
  name = "hiro#{n-1}"
  email = "hiro#{n-1}@dic.com"
  password = "000000"
  name_tag = User.name_tag
  if n == 0
    User.create!(last_target: "管理者として生きる", name_tag: name_tag, uid: uid, role: "admin", name: "administrator", email: "admin@dic.com", password: password, password_confirmation: password)
  elsif n == 1
    User.create!(last_target: "健康かつ文芸的な心を忘れないフルスタックなエンジニア", name_tag: name_tag, uid: uid, role: "user", name: "hirokore", email: "yama@dic.com", password: password, password_confirmation: password)
  else
    User.create!(last_target: last_target, name_tag: name_tag, uid: uid, role: role, name: name, email: email, password: password, password_confirmation: password)
  end
end

# マイタスクデフォルト
Custom.create!(user_id: 1, title: "タスクデフォルト設定用", displayed: false) 

# デモ用マイタスク
Custom.create!(user_id: 2, title: "IT学習") 
Custom.create!(user_id: 2, title: "芸術活動") 
Custom.create!(user_id: 3, title: "修行") 

# デモ用タグ
Tag.create!(user_id: 2, name: "ITスキル", total_time: 980.0)
Tag.create!(user_id: 2, name: "読書スキル", total_time: 4200.0)
Tag.create!(user_id: 2, name: "ピアノ", total_time: 360.0)
Tag.create!(user_id: 3, name: "戦闘スキル", total_time: 9800.0)

# デモ用タスク
Task.create!(tag_ids: [1,2], user_id: 2, custom_id: 2, name: "チェリー本", detail: "チェリー本を読み、出てきたコードは試すこと", task_time: 3.0)
Task.create!(tag_ids: [1], user_id: 2, custom_id: 2, name: "diverテキスト学習", detail: "diverサイト内のテキストを読み進めたり、課題をクリアする。", task_time: 5.0)
Task.create!(tag_ids: [3], user_id: 2, custom_id: 3, name: "ピアノ", detail: "バイエルとブルグミュラーを進める", task_time: 1.0)
Task.create!(tag_ids: [4], user_id: 3, custom_id: 4, name: "空手", detail: "道場にて修行", task_time: 2.5)
Task.create!(tag_ids: [4], user_id: 3, custom_id: 4, name: "柔術", detail: "道場にて修行", task_time: 2.5)
Task.create!(tag_ids: [4], user_id: 3, custom_id: 4, name: "中国拳法", detail: "道場にて修行", task_time: 2.5)
Task.create!(tag_ids: [4], user_id: 3, custom_id: 4, name: "ムエタイ", detail: "道場にて修行", task_time: 2.5)
Task.create!(tag_ids: [4], user_id: 3, custom_id: 4, name: "剣道", detail: "道場にて修行", task_time: 2.5)

# User機能デモ用
user_admin = User.second
user_admin.following_ids = [2,3,4]
user_admin.follower_ids = [2,3,4]