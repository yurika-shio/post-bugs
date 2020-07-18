class Article < ApplicationRecord
	belongs_to :user
	has_many :article_categories, dependent: :destroy
	has_many :categories, through: :article_categories
	has_many :comments

	scope :from_category, -> (category_id)  { where(id: article_ids = ArticleCategory.where(category_id: category_id).select(:article_id))}

	def self.search_by_title(titles)
		articles = Article.where(is_completed: true).where('title LIKE ?', "%#{titles}%")
	end


	def save_categories(tags)
		current_tags = self.categories.pluck(:category_name) unless self.categories.nil?
		old_tags = current_tags - tags
		new_tags = tags - current_tags

		# Destroy old taggings:
		old_tags.each do |old_name|
			self.categories.delete Category.find_by(category_name:old_name)
		end

		# Create new taggings:
		new_tags.each do |new_name|
			article_category = Category.find_or_create_by(category_name:new_name)
			self.categories << article_category
		end
	end


end
