require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:article) { build(:article, user_id: user.id) }
    let!(:comment) { build(:comment, article_id: article.id) }

    context 'commentカラム' do
      it '空欄でないこと' do
        comment.comment = ''
        expect(comment.valid?).to eq false;
      end

      it '200文字以下であること' do
        comment.comment = Faker::Lorem.characters(number:201)
        expect(comment.valid?).to eq false;
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Commentモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end

      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:article).macro).to eq :belongs_to
      end
    end
  end
end