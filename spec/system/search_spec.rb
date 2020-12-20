require 'rails_helper'

describe 'イベント検索機能', type: :system do
  context 'キーワードで検索した場合' do
    before do
      @user_1 = FactoryBot.create(:test_user_1)
      @group_1 = FactoryBot.create(:test_group_1, owner: @user_1 )
    end
    it 'イベント一覧画面に該当するイベント名が表示(キーワード)' do
      visit new_user_session_path
      fill_in "user[email]", with: 'test_user_1@example.com'
      fill_in "user[password]", with: 'test_user_1@example.com'
      click_on 'commit'

      visit new_organizing_group_event_path(group_id: @group_1.id)
      fill_in 'event[name]', with: 'test_event_1'
      fill_in 'event[schedule]', with: (DateTime.current + 2).strftime("%m%d%Y\t%I%M%P")
      fill_in 'event[content]', with: 'キーワード検索：まんぼう'
      choose "#{@user_1.name}"
      choose "オンラインで企画"
      select "アイスランド語", from: "event[event_languages_attributes][0][language_id]", visible: false
      fill_in 'event[event_languages_attributes][0][max]', with: 10
      click_on 'commit'
      click_on 'logout-btn'

      visit events_path
      fill_in 'q[name_or_content_or_address_cont]', with: 'まんぼう'
      click_on 'search-submit-1'
      expect(page).to have_content 'test_event_1'
    end
  end
  context '言語で検索した場合' do
    before do
      @user_1 = FactoryBot.create(:test_user_1)
      @group_1 = FactoryBot.create(:test_group_1, owner: @user_1 )
    end
    it 'イベント一覧画面に該当するイベント名が表示(言語)' do
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
      click_on 'logout-btn'

      visit events_path
      select "アイスランド語", from: "q[event_languages_language_id_eq]", visible: false
      click_on 'search-submit-1'
      expect(page).to have_content 'test_event_1'
    end
  end
end
