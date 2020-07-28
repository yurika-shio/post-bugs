FactoryBot.define do
  factory :categories, class: Category do
    sequence(:category_name) { |n| "category_name_#{n}" }
    # category_name { :category_list }
  end
end
