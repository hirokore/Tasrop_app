require 'rails_helper'

describe '卒業アプリ制作機能要件', type: :system do
  before do
    user = FactoryBot.create(:user, name_tag: "1111")
    tag = FactoryBot.create(:tag)
    custom = FactoryBot.create(:custom)
    task = FactoryBot.create(:task)  
  end
  describe '項番1,2 タスク/タグ作成保存' do
    context 'タグを作成した場合' do
      it '登録完了の通知が確認できる' do
        visit new_user_session_path
        fill_in "user[email]",	with: "test01@dic.com" 
        fill_in "user[password]",	with: "000000"
        click_on "commit"
        visit new_tag_path
        fill_in "tag_name",	with: "tag_test"
        click_on "タグ設定"
        expect(page).to have_content("登録完了")
      end
    end
    context 'タスク名/タスク内容/タスク工数/タグを入力してタスク作成をした場合' do
      it '登録完了の通知が確認できる' do
        visit new_user_session_path
        fill_in "user[email]",	with: "test01@dic.com" 
        fill_in "user[password]",	with: "000000"
        click_on "commit"
        visit new_task_path
        fill_in "custom_title",	with: "test_title"
        fill_in "custom_task",	with: "test_task"
        fill_in "custom_time", with: "1.0"
        check 'test01'
        click_on "タスク設定"
        expect(page).to have_content("登録完了")
      end
    end
  end
  describe '項番3 マイタスク作成/保存' do
    context 'マイタスクを作成した場合' do
      it '登録完了の通知が確認できる' do
        visit new_user_session_path
        fill_in "user[email]",	with: "test01@dic.com" 
        fill_in "user[password]",	with: "000000"
        click_on "commit"
        visit new_custom_path
        fill_in "custom_title",	with: "mytask_test"
        check 'test01'
        click_on "マイタスク設定"
        expect(page).to have_content("登録完了")
      end
    end
  end
  describe '項番4,8 マイタスク表示/進捗確認' do
    context 'マイタスク登録後、作成したマイタスクページを確認した場合' do
      it '作成したマイタスクが確認できる' do
        visit new_user_session_path
        fill_in "user[email]",	with: "test01@dic.com" 
        fill_in "user[password]",	with: "000000"
        click_on "commit"
        visit new_custom_path
        fill_in "custom_title",	with: "mytask_test"
        check 'test01'
        click_on "マイタスク設定"
        visit custom_path(User.last.id)
        expect(page).to have_content("mytask_test")
        expect(page).to have_content("0%")
      end
    end
  end
  describe '項番5 マイタスク編集/削除' do
    context 'マイタスク登録後、作成したマイタスクページを編集した場合' do
      it '編集完了の通知が確認できる' do
        visit new_user_session_path
        fill_in "user[email]",	with: "test01@dic.com" 
        fill_in "user[password]",	with: "000000"
        click_on "commit"
        visit new_custom_path
        fill_in "custom_title",	with: "mytask_test"
        check 'test01'
        click_on "マイタスク設定"
        visit edit_custom_path(Custom.last.id)
        fill_in "custom_title",	with: "change_test"
        click_on "マイタスク設定"
        expect(page).to have_content("編集完了")
      end
    end
    context 'マイタスク登録後、作成したマイタスクページを削除した場合' do
      it '削除完了の通知が確認できる' do
        visit new_user_session_path
        fill_in "user[email]",	with: "test01@dic.com" 
        fill_in "user[password]",	with: "000000"
        click_on "commit"
        visit new_custom_path
        fill_in "custom_title",	with: "mytask_test"
        check 'test01'
        click_on "マイタスク設定"
        page.accept_confirm do
          click_on "削除", match: :first
        end
        expect(page).to have_content("削除完了")
      end
    end
  end
  describe '項番6-7 マイページ作成/保存(ユーザー作成した段階で作成されるため、編集と表示の確認のみ)' do
    context 'ユーザー作成後にマイページの編集を行った場合' do
      it '編集完了の通知が確認でき内容が表示される' do
        visit new_user_session_path
        fill_in "user[email]",	with: "test01@dic.com" 
        fill_in "user[password]",	with: "000000"
        click_on "commit"
        visit edit_user_registration_path
        fill_in "user[last_target]",	with: "last_tagert"
        fill_in "user[password]",	with: "000000"
        fill_in "user_password_confirmation",	with: "000000"
        click_on "更新"
        expect(page).to have_content("アカウント情報を変更しました。")
        expect(page).to have_content("last_tagert")
      end
    end
  end
  describe '項番9 タグ毎の進捗表示機能' do
    context 'タグ作成後にマイページを確認した場合' do
      it '作成したタグの進捗度が確認できる' do
        visit new_user_session_path
        fill_in "user[email]",	with: "test01@dic.com" 
        fill_in "user[password]",	with: "000000"
        click_on "commit"
        visit new_tag_path
        fill_in "tag_name",	with: "tag_test"
        click_on "タグ設定"
        visit user_path(1)
        expect(page).to have_content("tag_test")
      end
    end
  end
  describe '項番10,12,14 ログイン関連' do
    context 'ゲストログインをした場合' do
      it 'ゲストユーザーとしてログインしたという通知が確認できる' do
        visit new_user_registration_path
        click_on "ゲストログイン"
        expect(page).to have_content("ゲストユーザーとしてログインしました。")
      end
    end
    context '管理者ログインをした場合' do
      it '管理者としてログインしたという通知が確認できる' do
        visit new_user_registration_path
        click_on "ゲスト管理者ログイン"
        expect(page).to have_content("ゲスト管理者ユーザーとしてログインしました。")
      end
    end
    context '管理者ログインをした場合' do
      it '管理者ページに遷移することができる' do
        visit new_user_registration_path
        click_on "ゲスト管理者ログイン"
        visit users_path
        expect(page).to have_content("管理者ページ")
      end
    end
    context '管理者ログインでない場合' do
      it '管理者ページに遷移することができない' do
        visit new_user_registration_path
        click_on "ゲストログイン"
        visit users_path
        expect(page).not_to have_content("管理者ページ")
      end
    end
  end
  describe '項番11 ページネーションが実装されていること' do
    context '管理者ページを表示し,ページネーションのNextを押した場合' do
      it '6番目に作成されたユーザーが確認できる' do
        [:second_user,:user3,:user4,:user5,:user6].each do |user|
          FactoryBot.create(user)
        end
        visit new_user_registration_path
        click_on "ゲスト管理者ログイン"
        visit users_path
        click_on "Next"
        expect(page).to have_content("test06")
      end
    end
  end
  describe '項番13 ユーザー間で繋がることが可能になる' do
    context '二つのユーザーを作成し、ネームタグ検索をしてフォローボタンを押した場合' do
      it '一つ目のユーザーが二つ目のユーザーをフォローできる' do
        FactoryBot.create(:second_user, name_tag: "2222")
        visit new_user_session_path
        fill_in "user[email]",	with: "test01@dic.com" 
        fill_in "user[password]",	with: "000000"
        click_on "commit"
        click_on "ユーザー検索"
        fill_in "q[name_tag_eq]",	with: "2222"
        click_on "検索"
        click_on "commit"
        click_on "フォロー"
        expect(page).to have_content("test02")
      end
    end
  end
  context '二つのユーザーを作成し、ネームタグ検索をしてフォローボタンを押した場合' do
    it '一つ上のテスト後、二つ目のフォロワーに一つ目のユーザーがあり、フォローをすることでDMページに相互フォローとなること' do
      FactoryBot.create(:second_user, name_tag: "2222")
      visit new_user_session_path
      fill_in "user[email]",	with: "test01@dic.com" 
      fill_in "user[password]",	with: "000000"
      click_on "commit"
      click_on "ユーザー検索"
      fill_in "q[name_tag_eq]",	with: "2222"
      click_on "検索"
      click_on "commit"
      click_on "ログアウト"
      visit new_user_session_path
      fill_in "user[email]",	with: "test02@dic.com" 
      fill_in "user[password]",	with: "000000"
      click_on "commit"
      click_on "フォロワー", match: :first
      click_on "commit"
      expect(page).to have_content("test01")
      click_on "DM"
      expect(page).to have_content("test01")
    end
  end
end


