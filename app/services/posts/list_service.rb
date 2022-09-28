# frozen_string_literal: true

module Posts
  class ListService < BaseService
    def call
      Post.includes(:author).all.to_a
    end
  end
end
