require 'rails_helper'

describe 'トップページのテスト' do
  before do
    visit root_path
  end
  it '新規登録画面のリンクを押下すると新規登録画面が表示されること' do
    click_link 'さぁ、はじめよう！'
    expect(current_path).to eq(new_user_registration_path)
  end
  # it 'Sign Upリンクが表示される' do
  #   signup_link = find_all('a')[5].native.inner_text
  #   expect(signup_link).to match(/sign up/i)
  #   expect(page).to have_link signup_link, href: new_user_registration_path
  # end
end