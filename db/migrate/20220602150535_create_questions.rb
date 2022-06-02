class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :riding_experience
      t.text :content, null: false
      t.text :answer

      t.timestamps
    end
  end
end
