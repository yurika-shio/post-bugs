require 'rails_helper'

RSpec.describe 'Bookモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:article) { build(:article, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        article.title = ''
        expect(article.valid?).to eq false;
      end
    end

    context 'error_nameカラム' do
      it '空欄でないこと' do
        article.error_name = ''
        expect(article.valid?).to eq false;
      end
    end

    context 'factorカラム' do
      it '空欄でないこと' do
        article.factor = ''
        expect(article.valid?).to eq false;
      end
    end

    context 'introductionカラム' do
      it '空欄でないこと' do
        article.introduction = ''
        expect(article.valid?).to eq false;
      end
    end

    context 'resultカラム' do
      it '空欄でないこと' do
        article.result = ''
        expect(article.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Articleモデルとの関係' do
      it 'N:1となっている' do
        expect(Article.reflect_on_association(:user).macro).to eq :belongs_to
      end

      it '1:Nとなっている' do
        expect(Article.reflect_on_association(:article_categories).macro).to eq :has_many
      end

      it '1:Nとなっている' do
        expect(Article.reflect_on_association(:categories).macro).to eq :has_many
      end

      it '1:Nとなっている' do
        expect(Article.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
  end
end