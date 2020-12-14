class CreateImageposts < ActiveRecord::Migration[6.0]
  def change
    create_table :imageposts do |t|
      t.text :content
      t.string :image
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :imageposts, [:user_id, :created_at]
  end
end
