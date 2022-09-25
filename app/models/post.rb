# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author, inverse_of: :posts, autosave: true

  has_one :author_profile, through: :author, source: :profile

  has_many :post_tags, inverse_of: :post, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :title, allow_blank: false, presence: true

  scope :published, -> { where.not(published_at: nil) }
  scope :recents, -> { where('created_at > ?', 3.months.ago) }

  def short_title(**args)
    title.truncate(args[:count] || 10)
  end

  def tags_list
    tags.map(&:name).join(', ')
  end

  def upper_title
    title.upcase
  end
end
