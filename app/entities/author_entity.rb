# frozen_string_literal: true

class AuthorEntity
  include Entity

  FIELDS = %w[id name age email].freeze
  RELATIONS = {
    posts: PostEntity
  }.freeze

  def to_s
    "#{name} (#{age})"
  end
end
