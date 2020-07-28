FactoryBot.define do
  factory :categories, class: Category do
    sequence(:category_name) { |n| "category_name_#{n}" }
  end
end
