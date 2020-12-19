require 'rails_helper'

describe 'ユーザーCRUD+ログイン機能', type: :system do
  describe '新規作成機能' do
    context 'サインアップ画面から新規作成した場合' do
      it 'アカウント作成noticeが表示' do
        visit new_user_registration_path
        fill_in "user[name]", with: 'test_user_1'
        fill_in "user[email]", with: 'test_user_1@example.com'
        fill_in "user[introduction]", with: 'Hello!'
        fill_in "user[password]", with: 'test_user_1@example.com'
        fill_in "user[password_confirmation]", with: 'test_user_1@example.com'
        click_on 'commit'
        expect(page).to have_content 'アカウント登録が完了しました'
      end
    end
  end
  describe 'ログイン機能' do
    context 'ログインした場合' do
      before do
        @test_user_1 = FactoryBot.create(:test_user_1)
      end
      it 'ログインnoticeが表示' do
        visit new_user_session_path
        fill_in "user[email]", with: 'test_user_1@example.com'
        fill_in "user[password]", with: 'test_user_1@example.com'
        click_on 'commit'
        expect(page).to have_content 'ログインしました'
      end
    end
    context 'ログイン後、ログアウトした場合' do
      before do
        @test_user_1 = FactoryBot.create(:test_user_1)
      end
      it 'ログアウトnoticeが表示' do
        visit new_user_session_path
        fill_in "user[email]", with: 'test_user_1@example.com'
        fill_in "user[password]", with: 'test_user_1@example.com'
        click_on 'commit'
        click_on 'logout-btn'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe 'ユーザ編集機能' do
    context 'ログイン後、ユーザ編集した場合' do
      before do
        @test_user_1 = FactoryBot.create(:test_user_1)
      end
      it 'アカウント情報変更noticeが表示' do
        visit new_user_session_path
        fill_in "user[email]", with: 'test_user_1@example.com'
        fill_in "user[password]", with: 'test_user_1@example.com'
        click_on 'commit'

        visit "/profile/#{@test_user_1.id}"
        click_on 'edit-btn'

        fill_in "user[introduction]", with: "Hello, again!"
        fill_in "user[current_password]", with: "test_user_1@example.com"
        click_on 'commit'
        expect(page).to have_content 'アカウント情報を変更しました'
      end
    end
  end
  describe 'ユーザ削除機能' do
    context 'ログイン後、ユーザ削除した場合' do
      before do
        @test_user_1 = FactoryBot.create(:test_user_1)
      end
      it 'ユーザ削除noticeが表示' do
        visit new_user_session_path
        fill_in "user[email]", with: 'test_user_1@example.com'
        fill_in "user[password]", with: 'test_user_1@example.com'
        click_on 'commit'

        visit "/profile/#{@test_user_1.id}"
        click_on 'edit-btn'

        page.accept_confirm do
          click_on "delete-btn"
        end
        expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております'
      end
    end
  end
end
