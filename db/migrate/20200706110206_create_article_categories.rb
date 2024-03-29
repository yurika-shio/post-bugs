class CreateArticleCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :article_categories do |t|
    	t.integer :article_id
    	t.integer :category_id

      t.timestamps
    end
    add_index :article_categories, :article_id
    add_index :article_categories, :category_id
    add_index :article_categories, [:article_id,:category_id],unique: true
  end
end
