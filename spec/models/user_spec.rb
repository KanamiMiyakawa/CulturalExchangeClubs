require 'rails_helper'

RSpec.describe User, type: :model do

  it '名前、email、パスワードがある場合、有効である' do
    user = User.new(
      name: "model_test_1",
      email: "model_test_1@example.com",
      password: "model_test_1@example.com"
    )
    expect(user).to be_valid
  end

  it '名前がないと無効' do
    user = User.new(
      name: nil,
      email: "model_test_1@example.com",
      password: "model_test_1@example.com"
    )
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it 'emailがメールアドレス形式でないと無効' do
    user = User.new(
      name: "model_test_1",
      email: "model_test_1",
      password: "model_test_1@example.com"
    )
    user.valid?
    expect(user.errors[:email]).to include("は不正な値です")
  end

  it 'emailが重複すると無効' do
    user = User.create(
      name: "model_test_1",
      email: "model_test_1@example.com",
      password: "model_test_1@example.com"
    )
    user2 = User.new(
      name: "model_test_1",
      email: "model_test_1@example.com",
      password: "model_test_1@example.com"
    )
    user2.valid?
    expect(user2.errors[:email]).to include("はすでに存在します")
  end

  it 'パスワードがないと無効' do
    user = User.new(
      name: "model_test_1",
      email: "model_test_1@example.com",
      password: nil
    )
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

end
