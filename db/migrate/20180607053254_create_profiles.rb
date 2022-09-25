# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.belongs_to :author, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
