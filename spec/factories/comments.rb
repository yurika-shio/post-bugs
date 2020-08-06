FactoryBot.define do
	factory :comment do
		sequence(:comment) { |n| "Comment#{n}" }
	end
end