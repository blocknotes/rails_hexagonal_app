# frozen_string_literal: true

module Posts
  class ListService < BaseService
    def call
      PostsRepository.list_posts_with_authors
    end
  end
end
