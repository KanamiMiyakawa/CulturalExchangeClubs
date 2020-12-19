FactoryBot.define do

  factory :test_group_1, class: Group do
    name { "test_group_1" }
    detail { "Hello" }
    permission { false }
  end
end
