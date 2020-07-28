require 'rails_helper'

describe 'ヘッダーのテスト' do
  describe 'ログインしていない場合' do
    before do
      visit root_path
    end
    context 'ヘッダーの表示とリンクを確認' do
      subject { page }
      it 'タイトルが表示される' do
        is_expected.to have_content 'PostBugs'
      end
      it 'TOPのリンクを押下するとTOP画面が表示されること' do
        click_link 'TOP'
        expect(current_path).to eq(top_path)
      end

      it 'ABOUTのリンクを押下するとABOUT画面が表示されること' do
        click_link 'ABOUT'
        expect(current_path).to eq(about_path)
      end

      it '新規登録のリンクを押下すると新規登録画面が表示されること' do
        click_link '新規登録'
        expect(current_path).to eq(new_user_registration_path)
      end

      it 'ログインのリンクを押下するとログイン画面が表示されること' do
        click_link 'ログイン'
        expect(current_path).to eq(new_user_session_path)
      end
  	end
  end

  describe 'ログインしている場合' do
    let(:user_a) { FactoryBot.create(:user) }
    before do
      visit new_user_session_path
      fill_in 'Email', with: user_a.email
      fill_in 'Password', with: user_a.password
      click_button 'Log in'
    end
    context 'ヘッダーの表示とリンクを確認' do
      subject { page }
      it 'タイトルが表示される' do
        is_expected.to have_content 'PostBugs'
      end
      it 'ABOUTのリンクを押下するとABOUT画面が表示されること' do
        click_link 'ABOUT'
        expect(current_path).to eq(about_path)
      end
      it 'MyPageのリンクを押下するとMyPage画面が表示されること' do
        click_link 'MyPage'
        visit current_url
      end
      it '記事一覧画面のリンクを押下すると記事一覧画面が表示されること' do
        click_link "Article's"
        expect(current_path).to eq(articles_path)
      end
      it 'ログアウトのリンクを押下するとログアウトされログイン画面が表示されること' do
        logout_link = find_all('a')[3].native.inner_text
        logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link logout_link
        expect(page).to have_css('div', class: 'navbar-notice')
      end
    end
  end
end
