class CreateCategoryTopicships < ActiveRecord::Migration[6.0]
  def change
    create_table :category_topicships do |t|

      t.timestamps
    end
  end
end
