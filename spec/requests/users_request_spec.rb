require 'rails_helper'

describe 'ユーザー認証のテスト' do
  describe 'ユーザー新規登録' do
  	let(:user_a) { FactoryBot.create(:user) }
    before do
      visit new_user_registration_path
    end
    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        fill_in 'Name', with: user_a.name
        fill_in 'Email', with: user_a.email
        fill_in 'Password', with: user_a.password
        # fill_in 'Password_confirmation', with: user_a.password
        click_button 'Sign up'

        expect(page).to have_css('div', class: 'navbar-notice')
      end
      it '新規登録に失敗する' do
        fill_in 'Name', with: ''
        fill_in 'Email', with: ''
        fill_in 'Password', with: ''
        # fill_in 'Password_confirmation', with: ''
        click_button 'Sign up'

        expect(page).to have_content 'error'
      end
    end
  end
  describe 'ユーザーログイン' do
    let(:user_b) { FactoryBot.create(:user) }
    before do
      visit new_user_session_path
    end
    context 'ログイン画面に遷移' do
      let(:user_b) { FactoryBot.create(:user) }
      it 'ログインに成功する' do
        fill_in 'Email', with: user_b.email
        fill_in 'Password', with: user_b.password
        click_button 'Log in'

        expect(page).to have_css('div', class: 'navbar-notice')
      end

      it 'ログインに失敗する' do
        fill_in 'Email', with: ''
        fill_in 'Password', with: ''
        click_button 'Log in'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end

describe 'ユーザーのテスト' do
  let!(:user_a) { FactoryBot.create(:user) }
  let!(:user_b) { FactoryBot.create(:user) }
  before do
    visit new_user_session_path
    fill_in 'Email', with: user_b.email
    fill_in 'Password', with: user_b.password
    click_button 'Log in'
  end
  describe 'サイドバーのテスト' do
    context '表示の確認' do
      it '画像が表示される' do
        expect(page).to have_css('img.profile_image')
      end
      it '名前が表示される' do
        expect(page).to have_content(user_b.name)
      end
      it '投稿数が表示される' do
        expect(page).to have_content(user_b.articles.count)
      end
      it '編集リンクが表示される' do
        visit user_path(user_b)
        expect(page).to have_link '', href: edit_user_path(user_b)
      end
    end
  end


  describe '編集のテスト' do
    context '自分の編集画面への遷移' do
      it '遷移できる' do
        visit edit_user_path(user_b)
        expect(current_path).to eq(edit_user_path(user_b))
      end
    end
    context '他人の編集画面への遷移' do
      it '遷移できない' do
        visit edit_user_path(user_a)
        expect(current_path).to eq(edit_user_path(user_a))
      end
    end

    context '表示の確認' do
      before do
        visit edit_user_path(user_b)
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user_b.name
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[profile_image]'
      end
      it '自己紹介編集フォームに自分の自己紹介が表示される' do
        expect(page).to have_field 'user[email]', with: user_b.email
      end
      it '編集に成功する' do
        click_button '編集内容を保存する'
        expect(page).to have_css('div', class: 'navbar-notice')
        # expect(current_path).to eq(edit_user_path)
      end
      it '編集に失敗する' do
        fill_in 'user[name]', with: ''
        click_button '編集内容を保存する'
        expect(page).to have_content 'error'
				#もう少し詳細にエラー文出したい
        # expect(current_path).to eq(edit_user_path(user_b))
      end
    end
  end

  describe '一覧画面のテスト' do
    before do
      visit users_path
    end
    context '表示の確認' do
      it 'Usersと表示される' do
        expect(page).to have_content('Users')
      end
      it '自分と他の人の画像が表示される' do
        expect(all('img.profile_image').size).to eq(3)
      end
      it '自分と他の人の名前が表示される' do
        expect(page).to have_content(user_b.name)
        expect(page).to have_content(user_a.name)
      end
      it 'Click!リンクが表示される' do
        expect(page).to have_link "Click!", href: user_path(user_b)
        expect(page).to have_link "Click!", href: user_path(user_a)
      end
    end
  end
  describe '詳細画面のテスト' do
  	let!(:article_a) { FactoryBot.create(:article, user_id: user_a.id) }
  	let!(:article_b) { FactoryBot.create(:article, user_id: user_b.id) }
  	let!(:categories_b) { FactoryBot.create(:categories) }
  	let!(:categories_a) { FactoryBot.create(:categories) }
  	let!(:article_categories_b) { FactoryBot.create(:article_categories, article_id: article_b.id, category_id: categories_b.id) }
  	let!(:article_categories_a) { FactoryBot.create(:article_categories, article_id: article_b.id, category_id: categories_a.id) }

    before do
      visit user_path(user_b)
    end
    context '表示の確認' do
      it '投稿一覧のtitleのリンク先が正しい' do
        expect(page).to have_link article_b.title, href: article_path(article_b)
      end
      it '投稿一覧にerrorが表示される' do
        expect(page).to have_content(article_b.error_name)
      end
      it '投稿一覧にcategoryが表示される' do
      	#byebug
        expect(page).to have_content(article_b.categories.first.category_name)
      end
      it '投稿一覧にcategoryに複数が表示される' do
      	categories = article_b.categories[0].category_name + ',' + article_b.categories[1].category_name
        expect(page).to have_content(categories)
      end
      it '投稿一覧にcategoryに複数が表示される' do
      	categories = article_b.categories[0].category_name + ',' + article_b.categories[1].category_name
        expect(page).to have_content(categories)
      end
    end
   #  context '自分の投稿詳細画面の表示を確認' do
  	# 	it '投稿の編集リンクが表示される' do
  	# 		visit article_path article_b
  	# 		expect(page).to have_link 'Edit', href: edit_article_path(article_b)
  	# 	end
  	# 	it '投稿の削除リンクが表示される' do
  	# 		visit article_path article_b
  	# 		expect(page).to have_link 'Destroy', href: article_path(article_b)
  	# 	end
  	# end
  	# context '他人の投稿詳細画面の表示を確認' do
  	# 	it '投稿の編集リンクが表示されない' do
  	# 		visit article_path(article_a)
  	# 		expect(page).to have_no_link 'Edit', href: edit_article_path(article_a)
  	# 	end
  	# 	it '投稿の削除リンクが表示されない' do
  	# 		visit article_path(article_a)
  	# 		expect(page).to have_no_link 'Destroy', href: article_path(article_a)
  	# 	end
  	# end
  end
end