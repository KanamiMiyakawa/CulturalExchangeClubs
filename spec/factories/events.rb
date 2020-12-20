FactoryBot.define do

  factory :test_event_1, class: Event do
    name {"model_test_1"}
    schedule {Time.zone.now + 2.days}
    content {"model_test_1"}
    online {false}
    address {'東京都墨田区押上１丁目１−２'}
  end

  factory :event_with_languages_1, class: Event do
    name {"model_test_1"}
    schedule {Time.zone.now + 2.days}
    content {"model_test_1"}
    online {false}
    address {'東京都墨田区押上１丁目１−２'}

    after(:build) do |event|
      language = Language.first
      create :test_event_language_1, event: event, language: language
    end
  end
end
