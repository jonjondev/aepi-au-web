class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.integer :board_id
      t.string :title
      t.string :body

      t.timestamps
    end
  end
end
