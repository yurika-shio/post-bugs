FactoryBot.define do
  factory :article_categories, class: ArticleCategory do
    sequence(:article_id) { |n| n }
    sequence(:category_id) { |n| n }
  end
end