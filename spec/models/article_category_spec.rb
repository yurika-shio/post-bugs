require 'rails_helper'

RSpec.describe 'ArticleCategoryモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:article) { build(:article, user_id: user.id) }
    let!(:categories) { build(:categories, article_id: article.id) }
    let!(:article_categories) { build(:article_categories, article_id: article.id, category_id: categories.id) }
  end

  describe 'アソシエーションのテスト' do
    context 'ArticleCategoryモデルとの関係' do

      it 'N:1となっている' do
        expect(ArticleCategory.reflect_on_association(:article).macro).to eq :belongs_to
      end

      it 'N:1となっている' do
        expect(ArticleCategory.reflect_on_association(:category).macro).to eq :belongs_to
      end
    end
  end
end