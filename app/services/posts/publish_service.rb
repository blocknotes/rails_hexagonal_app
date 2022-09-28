# frozen_string_literal: true

module Posts
  class PublishService < BaseService
    def call(post:)
      return false unless post.published_at.nil?

      post.update!(published_at: Time.now)
    end
  end
end
