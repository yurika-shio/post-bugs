require 'rails_helper'

RSpec.describe 'Categoryモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:article_a) { build(:article, user_id: user.id) }
    let!(:categories) { build(:categories) }
    let!(:article_categories) { build(:article_categories, article_id: article_a.id, category_id: categories.id) }

    context 'categoriesカラム' do
      it '50文字以下であること' do
        categories.category_name = Faker::Lorem.characters(number:51)
        expect(categories.valid?).to eq false;
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Categoryモデルとの関係' do

      it '1:Nとなっている' do
        expect(Category.reflect_on_association(:articles_categories).macro).to eq :has_many
      end

      it '1:Nとなっている' do
        expect(Category.reflect_on_association(:articles).macro).to eq :has_many
      end
    end
  end
end