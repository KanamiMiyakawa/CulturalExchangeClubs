# require 'rails_helper'
#
# RSpec.describe User, type: :model do
#

    # nested_attributesがうまくmodel specで再現できない、保留
#   it '名前、現在以降の日付、内容、オンラインでない場合は住所、言語アソシエーション、オーガナイザーID、グループID、ユーザーIDがあれば有効' do
#     user = FactoryBot.create(:test_user_1)
#     group = FactoryBot.create(:test_group_1, owner: user)
#     organizer = Organizer.last
#     event = FactoryBot.create(:event_with_languages_1, organizer: organizer, group: group, user: user)
#     # Event.new(
#     #   name: "model_test_1",
#     #   schedule: Time.zone.now + 2.days,
#     #   content: "model_test_1",
#     #   online: false,
#     #   address: '東京都墨田区押上１丁目１−２',
#     #   organizer_id: organizer.id,
#     #   group_id: group.id,
#     #   user_id: user.id,
#     #
#     #   event_languages_attributes: [
#     #     language_id: 1,
#     #     max: 10
#     #   ]
#     # )
#     expect(event).to be_valid
#   end
# end
