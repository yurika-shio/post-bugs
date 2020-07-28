require 'rails_helper'

describe '投稿のテスト' do
  let!(:user_a) { FactoryBot.create(:user) }
  let!(:user_b) { FactoryBot.create(:user) }
  let!(:article_a) { create(:article, user_id: user_a.id) }
  let!(:article_b) { create(:article, user_id: user_b.id) }
  let!(:categories_b) { FactoryBot.create(:categories) }
  let!(:article_categories_b) { FactoryBot.create(:article_categories, article_id: article_b.id, category_id: categories_b.id) }
  before do
  	visit new_user_session_path
  	fill_in 'Email', with: user_a.email
  	fill_in 'Password', with: user_a.password
  	click_button 'Log in'
    visit new_article_path
  end
  describe 'サイドバーのテスト' do
		context '表示の確認' do
		  it 'Post bugs and keep records !!と表示される' do
	    	expect(page).to have_content 'Post bugs and keep records !!'
		  end
		  it 'titleフォームが表示される' do
		  	expect(page).to have_field 'article[title]'
		  end
		  it 'error_nameフォームが表示される' do
		  	expect(page).to have_field 'article[error_name]'
		  end
      it 'introductionフォームが表示される' do
        expect(page).to have_field 'article[introduction]'
      end
      it 'factorフォームが表示される' do
        expect(page).to have_field 'article[factor]'
      end
      it 'resultフォームが表示される' do
        expect(page).to have_field 'article[result]'
      end
      it 'categoriesフォームが表示される' do
        expect(page).to have_css('ul', id: 'article-tags')
      end
		  it 'Createボタンが表示される' do
		  	expect(page).to have_button 'Create'
		  end
      it 'Createボタンが表示される' do
        expect(page).to have_button 'Keep'
      end
		  it '投稿に成功する' do
        click_button 'Create'
        expect(page).to have_css('div', class: 'navbar-notice')
		  end
		  it '投稿に失敗する' do
		  	click_button 'Create'
		  	expect(page).to have_content 'error'
		  end
		end
  end

  describe '編集のテスト' do
  	context '自分の投稿の編集画面への遷移' do
  	  it '遷移できる' do
	  		visit edit_article_path(article_a)
	  		expect(current_path).to eq('/articles/' + article_a.id.to_s + '/edit')
	  	end
	  end
		context '他人の投稿の編集画面への遷移' do
		  it '遷移できない' do
		    visit edit_article_path(article_b)
		    expect(current_path).to eq('/')
		  end
		end
		context '表示の確認' do
			before do
				visit edit_article_path(article_a)
			end
			it 'Editing Articleと表示される' do
				expect(page).to have_content('Editing Article')
			end
			it 'title編集フォームが表示される' do
				expect(page).to have_field 'article[title]', with: article_a.title
			end
      it 'error_nameフォームが表示される' do
        expect(page).to have_field 'article[error_name]', with: article_a.error_name
      end
      it 'introductionフォームが表示される' do
        expect(page).to have_field 'article[introduction]', with: article_a.introduction
      end
      it 'factorフォームが表示される' do
        expect(page).to have_field 'article[factor]', with: article_a.factor
      end
      it 'resultフォームが表示される' do
        expect(page).to have_field 'article[result]', with: article_a.result
      end
      it 'categoriesフォームが表示される' do
        expect(page).to have_css('div', class: 'article-tags-field form_group')
        expect(page).to have_field,class: 'Category'
      end
		end
		context 'フォームの確認' do
			it '編集に成功する' do
				visit edit_article_path(article_a)
				click_button 'Create'
				expect(page).to have_css('div', class: 'navbar-notice')
			end
			it '編集に失敗する' do
				visit edit_article_path(article_a)
				fill_in 'article[title]', with: ''
				click_button 'Create'
				expect(page).to have_content 'error'
			end
		end
	end

  describe '一覧画面のテスト' do
    before do
  		visit articles_path
  	end
  	context '表示の確認' do
  		it 'Articlesと表示される' do
  			expect(page).to have_content 'Articles'
  		end
  		it '自分と他人のタイトルの表示が正しい' do
  			expect(page).to have_content(title)
  		end
  	end
  end

  describe '詳細画面のテスト' do
  	context '自分・他人共通の投稿詳細画面の表示を確認' do
  		it '投稿のtitleが表示される' do
  			visit article_path(article_b)
  			expect(page).to have_content article_b.title
  		end
      it '投稿のerror_nameが表示される' do
        visit article_path(article_b)
        expect(page).to have_content article_b.error_name
      end
      it '投稿のintroductionが表示される' do
        visit article_path(article_b)
        expect(page).to have_content article_b.introduction
      end
      it '投稿のfactorが表示される' do
        visit article_path(article_b)
        expect(page).to have_content article_b.factor
      end
      it '投稿のresultが表示される' do
        visit article_path(article_b)
        expect(page).to have_content article_b.result
      end
  	end
  end
end