class ChangeBinaryImageOfArticles < ActiveRecord::Migration[5.2]
  def change
     change_column :articles, :image, :binary
  end
end
