class AddCategoryToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :category, :integer
  end
end
