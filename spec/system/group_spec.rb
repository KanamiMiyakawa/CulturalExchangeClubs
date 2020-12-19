require 'rails_helper'

describe 'グループCRUD+参加機能', type: :system do
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
  describe 'グループ削除機能' do
    context 'ログイン後、グループを削除した場合' do
      before do
        @user_1 = FactoryBot.create(:test_user_1)
        @group_1 = @user_1.own_groups.create!(name: "test_group_1", detail: "This is test_group_1")
      end
      it 'グループ削除noticeが表示' do
        visit new_user_session_path
        fill_in "user[email]", with: 'test_user_1@example.com'
        fill_in "user[password]", with: 'test_user_1@example.com'
        click_on 'commit'

        visit organizing_path
        page.accept_confirm do
          click_on "group#{@group_1.id}-delete-btn"
        end
        expect(page).to have_content 'グループを削除しました'
      end
    end
  end
  describe 'グループ参加機能' do
    context '自由参加のグループに参加した場合' do
      before do
        @user_1 = FactoryBot.create(:test_user_1)
        @user_2 = FactoryBot.create(:test_user_2)
        @group_1 = @user_1.own_groups.create!(name: "test_group_1", detail: "This is test_group_1", permission: false)
      end
      it 'グループメンバーが2人になっている' do
        visit new_user_session_path
        fill_in "user[email]", with: 'test_user_2@example.com'
        fill_in "user[password]", with: 'test_user_2@example.com'
        click_on 'commit'

        visit group_path(@group_1.id)
        click_on 'group-request-btn'
        expect(@group_1.members.count).to eq 2
      end
    end
    context '承認制のグループに参加し、オーガナイザーが許可した場合' do
      before do
        @user_1 = FactoryBot.create(:test_user_1)
        @user_2 = FactoryBot.create(:test_user_2)
        @group_1 = @user_1.own_groups.create!(name: "test_group_1", detail: "This is test_group_1", permission: true)
        @membership_1 = Member.create!(user_id: @user_2.id, group_id: @group_1.id, pending: true)
      end
      it 'リクエスト承認noticeが表示' do
        visit new_user_session_path
        fill_in "user[email]", with: 'test_user_1@example.com'
        fill_in "user[password]", with: 'test_user_1@example.com'
        click_on 'commit'

        visit organizing_path
        click_on "accept-member#{@membership_1.id}"
        expect(page).to have_content 'リクエストを許可しました'
      end
    end
  end
end
