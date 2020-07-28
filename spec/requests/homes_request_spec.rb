require 'rails_helper'

describe 'トップページのテスト' do
  let(:user_a) { FactoryBot.create(:user) }
  before do
    visit root_path
  end
  it '新規登録画面のリンクを押下すると新規登録画面が表示されること' do
    click_link 'さぁ、はじめよう！'
    expect(current_path).to eq(new_user_registration_path)
  end

  it 'サイト紹介画面のリンクを押下するとサイト紹介画面が表示されること' do
    click_link 'About it'
    expect(current_path).to eq(about_path)
    expect(page).to have_link 'さぁ、はじめよう！', href: new_user_registration_path
  end

  context 'ログインしている場合の挙動を確認' do
      before do
        visit new_user_session_path
        fill_in 'Email', with: user_a.email
        fill_in 'Password', with: user_a.password
        click_button 'Log in'
        visit current_url
      end
      it 'Log inリンクをクリックしたらマイページ画面へ遷移すること' do
        login_link = find_all('a')[4].native.inner_text
        click_link login_link
        expect(page).to have_css('div', class: 'navbar-notice')
      end

    # context 'ログインしていない場合の挙動を確認' do
    #   it 'Log inリンクをクリックしたらログイン画面へ遷移する' do
    #     login_link = find_all('a')[4].native.inner_text
    #     click_link login_link
    #     expect(current_path).to eq(new_user_session_path)
    #   end
    #   it 'Sign Upリンクをクリックしたら新規登録画面に遷移する' do
    #     signup_link = find_all('a')[5].native.inner_text
    #     click_link signup_link
    #     expect(current_path).to eq(new_user_registration_path)
    #   end
    end
  context 'ログインしていない場合の挙動を確認' do
    it 'Log inリンクをクリックしたらログイン画面へ遷移すること' do
      login_link = find_all('a')[4].native.inner_text
      click_link login_link
      expect(current_path).to eq(new_user_session_path)
    end
  end
end