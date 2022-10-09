# frozen_string_literal: true

class PostEntity
  include Entity

  FIELDS = %w[id title description category position published_at created_at].freeze
  RELATIONS = {
    author: AuthorEntity,
    tags: TagEntity
  }.freeze

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
