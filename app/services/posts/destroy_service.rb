# frozen_string_literal: true

module Posts
  class DestroyService < BaseService
    def call(post:)
      post.destroy
    end
  end
end
