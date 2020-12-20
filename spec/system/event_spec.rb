require 'rails_helper'

describe 'イベントCRUD+参加機能', type: :system do
  describe 'イベント作成した場合' do
    before do
      @user_1 = FactoryBot.create(:test_user_1)
      @group_1 = FactoryBot.create(:test_group_1, owner: @user_1)
    end
    it 'イベント作成noticeが表示' do
      visit new_user_session_path
      fill_in "user[email]", with: 'test_user_1@example.com'
      fill_in "user[password]", with: 'test_user_1@example.com'
      click_on 'commit'

      visit new_organizing_group_event_path(group_id: @group_1.id)
      fill_in 'event[name]', with: 'test_event_1'
      fill_in 'event[schedule]', with: (DateTime.current + 2).strftime("%m%d%Y\t%I%M%P")
      fill_in 'event[content]', with: 'Hello!'
      choose "#{@user_1.name}"
      choose "オンラインで企画"
      select "アイスランド語", from: "event[event_languages_attributes][0][language_id]", visible: false
      fill_in 'event[event_languages_attributes][0][max]', with: 10
      click_on 'commit'
      expect(page).to have_content 'イベントを作成しました'
    end
  end
  describe 'イベント編集した場合' do
    before do
      @user_1 = FactoryBot.create(:test_user_1)
      @group_1 = FactoryBot.create(:test_group_1, owner: @user_1 )
    end
    it 'イベント編集noticeが表示' do
      visit new_user_session_path
      fill_in "user[email]", with: 'test_user_1@example.com'
      fill_in "user[password]", with: 'test_user_1@example.com'
      click_on 'commit'

      visit new_organizing_group_event_path(group_id: @group_1.id)
      fill_in 'event[name]', with: 'test_event_1'
      fill_in 'event[schedule]', with: (DateTime.current + 2).strftime("%m%d%Y\t%I%M%P")
      fill_in 'event[content]', with: 'Hello!'
      choose "#{@user_1.name}"
      choose "オンラインで企画"
      select "アイスランド語", from: "event[event_languages_attributes][0][language_id]", visible: false
      fill_in 'event[event_languages_attributes][0][max]', with: 10
      click_on 'commit'

      @event_1 = Event.last

      visit edit_organizing_group_event_path(group_id: @group_1.id, id: @event_1.id)
      fill_in 'event[content]', with: 'Hello, again!'
      click_on 'commit'
      expect(page).to have_content 'イベントを更新しました'
    end
  end
  describe 'イベント削除した場合' do
    before do
      @user_1 = FactoryBot.create(:test_user_1)
      @group_1 = FactoryBot.create(:test_group_1, owner: @user_1 )
    end
    it 'イベント削除noticeが表示' do
      visit new_user_session_path
      fill_in "user[email]", with: 'test_user_1@example.com'
      fill_in "user[password]", with: 'test_user_1@example.com'
      click_on 'commit'

      visit new_organizing_group_event_path(group_id: @group_1.id)
      fill_in 'event[name]', with: 'test_event_1'
      fill_in 'event[schedule]', with: (DateTime.current + 2).strftime("%m%d%Y\t%I%M%P")
      fill_in 'event[content]', with: 'Hello!'
      choose "#{@user_1.name}"
      choose "オンラインで企画"
      select "アイスランド語", from: "event[event_languages_attributes][0][language_id]", visible: false
      fill_in 'event[event_languages_attributes][0][max]', with: 10
      click_on 'commit'

      @event = Event.last

      visit organizing_path
      page.accept_confirm do
        click_on "delete-event#{@event.id}-btn"
      end
      expect(page).to have_content 'イベントを削除しました'
    end
  end
  describe 'イベントに参加した場合' do
    before do
      @user_1 = FactoryBot.create(:test_user_1)
      @user_2 = FactoryBot.create(:test_user_2)
      @group_1 = FactoryBot.create(:test_group_1, owner: @user_1 )
    end
    it 'イベント参加者が1人になる' do
      visit new_user_session_path
      fill_in "user[email]", with: 'test_user_1@example.com'
      fill_in "user[password]", with: 'test_user_1@example.com'
      click_on 'commit'

      visit new_organizing_group_event_path(group_id: @group_1.id)
      fill_in 'event[name]', with: 'test_event_1'
      fill_in 'event[schedule]', with: (DateTime.current + 2).strftime("%m%d%Y\t%I%M%P")
      fill_in 'event[content]', with: 'Hello!'
      choose "#{@user_1.name}"
      choose "オンラインで企画"
      select "アイスランド語", from: "event[event_languages_attributes][0][language_id]", visible: false
      fill_in 'event[event_languages_attributes][0][max]', with: 10
      click_on 'commit'

      @event = Event.last

      click_on 'logout-btn'

      visit new_user_session_path
      fill_in "user[email]", with: 'test_user_2@example.com'
      fill_in "user[password]", with: 'test_user_2@example.com'
      click_on 'commit'

      visit event_path(@event)
      click_on 'commit'
      expect(@event.participants.count).to eq 1
    end
  end
end
