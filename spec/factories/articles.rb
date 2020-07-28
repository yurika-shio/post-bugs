FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "title_#{n}" }
    error_name  { "error_name" }
    introduction { "introduction" }
    factor { "factor" }
    result { "result" }
  end
end