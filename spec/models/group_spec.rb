require 'rails_helper'

RSpec.describe User, type: :model do

  it '名前、詳細、オーナーIDがある場合、有効である' do
    user = FactoryBot.create(:test_user_1)
    group = Group.new(
      name: "model_test_1",
      detail: "model_test_1",
      owner_id: user.id
    )
    expect(group).to be_valid
  end

  it '名前がないと無効' do
    user = FactoryBot.create(:test_user_1)
    group = Group.new(
      name: nil,
      detail: "model_test_1",
      owner_id: user.id
    )
    group.valid?
    expect(group.errors[:name]).to include("を入力してください")
  end

  it '詳細がないと無効' do
    user = FactoryBot.create(:test_user_1)
    group = Group.new(
      name: "model_test_1",
      detail: nil,
      owner_id: user.id
    )
    group.valid?
    expect(group.errors[:detail]).to include("を入力してください")
  end

  it 'オーナーIDがないと無効' do
    user = FactoryBot.create(:test_user_1)
    group = Group.new(
      name: "model_test_1",
      detail: "model_test_1",
      owner_id: nil
    )
    group.valid?
    expect(group.errors[:owner]).to include("を入力してください")
  end

end
