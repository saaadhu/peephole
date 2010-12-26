class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.string :author
      t.text :content
      t.datetime :posted_at
      t.references :user
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
