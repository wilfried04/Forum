class CreateTopicCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :topic_categories do |t|
      t.references :topic   , foreign_key: true
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
