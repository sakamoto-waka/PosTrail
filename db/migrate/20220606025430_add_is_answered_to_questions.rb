class AddIsAnsweredToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :is_answered, :boolean, default: false, null: false
  end
end
