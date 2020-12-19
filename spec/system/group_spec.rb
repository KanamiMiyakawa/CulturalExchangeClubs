require 'rails_helper'

describe 'グループCRUD機能', type: :system do
  describe 'グループ新規作成機能' do
    context 'ログイン後、グループを作成した場合' do
      before do
        @test_user_1 = FactoryBot.create(:test_user_1)
      end
      it 'グループ作成noticeが表示' do
        visit new_user_session_path
        fill_in "user[email]", with: 'test_user_1@example.com'
        fill_in "user[password]", with: 'test_user_1@example.com'
        click_on 'commit'

        visit new_group_path
        fill_in "group[name]", with: 'test_group_1'
        fill_in "group[detail]", with: 'This is test_group_1!'
        click_on 'commit'
        expect(page).to have_content 'グループを作成しました'
      end
    end
  end
  describe 'グループ編集機能' do
    context 'ログイン後、グループを編集した場合' do
      before do
        @user_1 = FactoryBot.create(:test_user_1)
        @group_1 = @user_1.own_groups.create!(name: "test_group_1", detail: "This is test_group_1")
      end
      it 'グループ編集noticeが表示' do
        visit new_user_session_path
        fill_in "user[email]", with: 'test_user_1@example.com'
        fill_in "user[password]", with: 'test_user_1@example.com'
        click_on 'commit'

        visit edit_organizing_group_path(@group_1.id)
        fill_in "group[detail]", with: 'Test is over'
        click_on 'commit'
        expect(page).to have_content 'グループを更新しました'
      end
    end
  end
end
