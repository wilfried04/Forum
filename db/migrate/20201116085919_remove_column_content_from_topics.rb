class RemoveColumnContentFromTopics < ActiveRecord::Migration[5.2]
  def change
    remove_column  :topics, :content, :text
  end
end
