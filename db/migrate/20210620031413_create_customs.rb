class CreateCustoms < ActiveRecord::Migration[5.2]
  def change
    create_table :customs do |t|
      t.references :user, foreign_key: true
      t.string "title", null: false
      t.boolean "displayed", default: true, null: false
      t.boolean "use_comment", default: false, null: false
      t.boolean "use_picture", default: false, null: false
      t.string :mentor

      t.timestamps
    end
  end
end
