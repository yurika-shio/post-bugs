class Comment < ApplicationRecord
	belongs_to :article
	belongs_to :user
	validates :comment, presence: true, length: {maximum: 200}
end
