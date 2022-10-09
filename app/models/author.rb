# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :posts, dependent: :nullify
  has_many :published_posts, -> { published }, class_name: 'Post', dependent: :nullify, inverse_of: :author
  has_many :recent_posts, -> { recents }, class_name: 'Post', dependent: :nullify, inverse_of: :author

  has_one :profile, inverse_of: :author, dependent: :destroy

  accepts_nested_attributes_for :profile, allow_destroy: true

  validates :email, format: { with: /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\z/i, message: 'Invalid email' }
end
