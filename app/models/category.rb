class Category < ApplicationRecord
	has_many :articles_categories, dependent: :destroy
	has_many :articles, through: :articles_categories
	validates :category_name,presence:true,length:{maximum:50}
end
