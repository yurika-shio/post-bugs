class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.integer :user_id
      t.string :title, null: false
      t.string :error_name, null: false
      t.text :introduction, null: false
      t.text :factor, null: false
      t.text :result, null: false
      t.string :reference
      t.boolean :is_completed, default: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false

      t.timestamps
    end
    add_index :articles,[:user_id,:created_at]
  end
end
