# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.belongs_to :author, foreign_key: true
      t.string :title
      t.text :description
      t.string :category
      t.float :position
      t.datetime :published_at

      t.timestamps
    end
  end
end
