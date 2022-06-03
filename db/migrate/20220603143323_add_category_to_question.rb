class AddCategoryToQuestion < ActiveRecord::Migration[6.1]
  def up
    add_column :questions, :category, :integer
    change_column :questions, :category, :integer, :null => false, default: 0
  end

  def down
    remove_column :questions, :category
  end

end
